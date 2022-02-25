//
//  SLWebCacheManager.m
//  DarkMode
//
//  Created by wsl on 2020/5/31.
//  Copyright © 2020 https://github.com/wsl2ls   ----- . All rights reserved.
//

#import "SLWebCacheManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "SLUrlCache.h"
#import "SLUrlProtocol.h"
#import "WKWebView+SLExtension.h"
#import "XENativeContext.h"
#import "iToast.h"
//#import "YYCache.h"

//实现原理参考 戴明大神：https://github.com/ming1016/STMURLCache
@interface SLWebCacheManager ()
@property (nonatomic, strong) NSMutableDictionary *responseDic;
//记录正在下载的任务、防止下载请求的循环调用
///内存缓存空间
@property (nonatomic, strong) NSCache *memoryCache;
@property (nonatomic, assign) BOOL  cacheEnabled;

//@property (nonatomic, strong) YYCache *memoryCache;
@end

@implementation SLWebCacheManager

#pragma mark - Public
+ (SLWebCacheManager *)shareInstance {
    static SLWebCacheManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SLWebCacheManager alloc] init];
    });
    return instance;
}
///启用缓存功能
- (void)openCache {
    self.cacheEnabled = YES;
    //注册协议类, 然后URL加载系统就会在请求发出时使用我们创建的协议对象对该请求进行拦截处理，不需要拦截的时候，要进行注销unregisterClass
    [WKWebView sl_registerSchemeForSupportHttpProtocol];
    if (self.isUsingURLProtocol) {
        [NSURLProtocol registerClass:[SLUrlProtocol class]];
    }else {
        SLUrlCache * urlCache = [[SLUrlCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:0];
        [NSURLCache setSharedURLCache:urlCache];
    }
    //添加内存警告监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}
///关闭缓存功能
- (void)closeCache {
    self.cacheEnabled = NO;
    [WKWebView sl_unregisterSchemeForSupportHttpProtocol];
    if (self.isUsingURLProtocol) {
        [NSURLProtocol unregisterClass:[SLUrlProtocol class]];
    }else {
//        [NSURLCache setSharedURLCache:nil];
    }
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
///是否缓存该请求，该请求是否在白名单里或合法
- (BOOL)canCacheRequest:(NSURLRequest *)request {
    if(!self.cacheEnabled)return FALSE;
    NSString *key = [self genKey:request];
    if([key containsString:@"sockjs-node"]) return NO;
    //User-Agent来过滤
    NSString *uAgent = [request.allHTTPHeaderFields objectForKey:@"User-Agent"];
    if (self.whiteUserAgent.length > 0) {
        if (uAgent) {
            if (![uAgent hasSuffix:self.whiteUserAgent]) {
                return NO;
            }
        } else {
            return NO;
        }
    }
    
    if(![uAgent containsString:@"Mozilla"]) // not webview
    {
        return NO;
    }
    
  
    
    //只允许GET方法通过，因为post请求body数据被清空, post body  由 ajaxhook.js 拦截后由原生处理.
    //如果通过 registerSchemeForCustomProtocol 注册了 http(s) scheme, 那么由WKWebView发起的所有 http(s)请求都会通过 IPC 传给主进程NSURLProtocol处理，导致post请求body被清空
    
    if (![request.HTTPMethod containsString:@"GET"]) {
        return NO;
    }

    // 不缓存视频
//    if ([request.URL.absoluteString.pathExtension isEqualToString:@"mp4"]) {
//        return NO;
//    }
    
    //对于域名黑名单的过滤
    if (self.blackListsHost.count > 0) {
        BOOL isExist = [self.blackListsHost containsObject:request.URL.host];
        if (isExist) {
            return NO;
        }
    }
    
    //对于域名白名单的过滤
    if (self.whiteListsHost.count > 0) {
        BOOL isExist = [self.whiteListsHost containsObject:request.URL.host];
        if (!isExist) {
            return NO;
        }
    }
    //请求地址白名单
    if (self.whiteListsRequestUrl.count > 0) {
        BOOL isExist = [self.whiteListsRequestUrl containsObject:request.URL.host];
        if (!isExist) {
            return NO;
        }
    }
    NSString *scheme = [[request.URL scheme] lowercaseString];
    if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
        //
    } else {
        return NO;
    }
//    NSLog(@"@intercept => %@",request.URL);
//    NSLog(@"@headers => %@",request.allHTTPHeaderFields);

    return YES;
}

#pragma mark - Cache Path
/// 对应请求的缓存文件/信息路径
- (NSString *)filePathFromRequest:(NSURLRequest *)request isInfo:(BOOL)info {
    NSString* key = [self genKey:request];
    if (info) {
        NSString *otherInfoFileName = [self cacheRequestOtherInfoFileName:key];
        NSString *fileInfoPath = [self cacheFilePath:otherInfoFileName];
        return fileInfoPath;
    }else{
        NSString *fileName = [self cacheRequestFileName:key];
        NSString *filePath = [self cacheFilePath:fileName];
        return filePath;
    }
}
///缓存数据文件名
- (NSString *)cacheRequestFileName:(NSString *)requestUrl {
    return [SLWebCacheManager md5Hash:[NSString stringWithFormat:@"%@",requestUrl]];
}
///缓存其他信息的文件名
- (NSString *)cacheRequestOtherInfoFileName:(NSString *)requestUrl {
    return [SLWebCacheManager md5Hash:[NSString stringWithFormat:@"%@-otherInfo",requestUrl]];
}
 
///缓存的文件路径
- (NSString *)cacheFilePath:(NSString *)file {
    NSString *path = [NSString stringWithFormat:@"%@/%@",self.diskPath,self.cacheFolder];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fm fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        //
    } else {
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *subDirPath = [NSString stringWithFormat:@"%@/%@/%@",self.diskPath,self.cacheFolder,self.subDirectory];
    if ([fm fileExistsAtPath:subDirPath isDirectory:&isDir] && isDir) {
        //
    } else {
        [fm createDirectoryAtPath:subDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *cFilePath = [NSString stringWithFormat:@"%@/%@",subDirPath,file];
    //    NSLog(@"%@",cFilePath);
    return cFilePath;
}
//url加密
+ (NSString *)md5Hash:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    NSString *md5Result = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5Result;
}
//缓存文件所在目录
- (NSString *)cacheFolderPath {
    return [NSString stringWithFormat:@"%@/%@/%@",self.diskPath,self.cacheFolder,self.subDirectory];
}

#pragma mark - Cache Manage
///写入缓存数据   内存和磁盘
- (BOOL)writeCacheData:(NSCachedURLResponse *)cachedURLResponse withRequest:(NSURLRequest *)request {
    NSDate *date = [NSDate date];
    NSHTTPURLResponse* httpres = (NSHTTPURLResponse*)cachedURLResponse.response;
    NSDictionary* headers = httpres.allHeaderFields?httpres.allHeaderFields:@{};
    NSDictionary *info = @{@"time" : [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]],
                           @"MIMEType" : cachedURLResponse.response.MIMEType ? cachedURLResponse.response.MIMEType :@"application/octet-stream",
                           @"textEncodingName" : cachedURLResponse.response.textEncodingName == nil ? @"": cachedURLResponse.response.textEncodingName,
                           @"headers": headers,
                           @"statuscode": @(httpres.statusCode)
    };
    
//    //写入磁盘
    BOOL result1 = [info writeToFile:[self filePathFromRequest:request isInfo:YES] atomically:YES];
    BOOL result2 = [cachedURLResponse.data writeToFile:[self filePathFromRequest:request isInfo:NO] atomically:YES];
    if(info[@"MIMEType"] && [info[@"MIMEType"] containsString:@"image/"])
        return result1 && result2;
    //写入内存
    NSString *key = [self genKey:request];
    [self.memoryCache setObject:cachedURLResponse.data forKey:[self cacheRequestFileName:key]];
    [self.memoryCache setObject:info forKey:[self cacheRequestOtherInfoFileName:[self genKey:request]]];
//
    return result1 && result2;
 
    // yycache 没有返回值
//    return TRUE;
}
-(NSString*)genKey:(NSURLRequest*) request {
    NSString* range = request.allHTTPHeaderFields[@"Range"];
    if(range){
        // 是视频
        NSString* key = [NSString stringWithFormat:@"%@%@",request.URL.absoluteString, range];
        return key;
    }else{
        return request.URL.absoluteString;
    }
}
///加载缓存数据   内存 -> 磁盘 ->网络
- (NSCachedURLResponse *)loadCachedResponeWithRequest:(NSURLRequest *)request {
    
    //加载内存cache
    BOOL isMemory = NO; //是否在内存中
    NSString* key = [self genKey:request];
    NSData *data = [self.memoryCache objectForKey:[self cacheRequestFileName:key]];
    NSDictionary *otherInfo = [self.memoryCache objectForKey:[self cacheRequestOtherInfoFileName:key]];
    if (data != nil) isMemory = YES;
    
    NSDate *date = [NSDate date];
    if (!isMemory) {
        //如果不在内存中
        NSString *filePath = [self filePathFromRequest:request isInfo:NO];
        NSString *otherInfoPath = [self filePathFromRequest:request isInfo:YES];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:filePath]) {
            //加载磁盘cache
            otherInfo = [NSDictionary dictionaryWithContentsOfFile:otherInfoPath];
            data = [NSData dataWithContentsOfFile:filePath];
          
            //写入内存
            if(data)
                [self.memoryCache setObject:data forKey:[self cacheRequestFileName:key]];
            if(otherInfo)
                [self.memoryCache setObject:otherInfo forKey:[self cacheRequestOtherInfoFileName:key]];
        }else {
            //磁盘里也没有cache
            return nil;
        }
    }
    
    //cache是否过期
    BOOL expire = false;
    if (self.cacheTime > 0) {
        NSInteger createTime = [[otherInfo objectForKey:@"time"] integerValue];
        if (createTime + self.cacheTime < [date timeIntervalSince1970]) {
            expire = true;
        }
    }
    if (expire == false) {

        // 写入 header 的问题 https://www.coder.work/article/455876
        //cache没过期
//        NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:request.URL MIMEType:[otherInfo objectForKey:@"MIMEType"] expectedContentLength:data.length textEncodingName:[otherInfo objectForKey:@"textEncodingName"]];
        NSHTTPURLResponse *response  =[[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:[[otherInfo objectForKey:@"statuscode"] intValue] HTTPVersion:@"HTTP/1.1" headerFields:[otherInfo objectForKey:@"headers"]];
   
        NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];

        if(!data){
            [self removeCacheFileWithRequest:request];
            return nil;
        }
        return cachedResponse;
    } else {
        //cache失效了，移除缓存文件
        [self removeCacheFileWithRequest:request];
    }
    return nil;
}
///从网络读取数据并写入本地
- (NSCachedURLResponse *)requestNetworkData:(NSURLRequest *)request{
    __block NSCachedURLResponse *cachedResponse = nil;
    NSString *key = [self genKey:request];
    id isExist = [self.responseDic objectForKey:key ];
    if (isExist == nil) {
        [self.responseDic setValue:[NSNumber numberWithBool:TRUE] forKey:key];
        
        NSLog(@"req => %@:%@",request.URL, request.HTTPMethod);
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          
            if (error) {
                cachedResponse = nil;
#ifdef DEBUG
        [XENP(iToast) toast:[NSString stringWithFormat:@"%@", error]];
#endif
            } else {
                cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
                //写入本地缓存
                [self writeCacheData:cachedResponse withRequest:request];
            }
        }];
        [task resume];
        return cachedResponse;
    }
    return nil;
}
///移除缓存文件
- (void)removeCacheFileWithRequest:(NSURLRequest *)request {
    //清除内存cache
    NSString *key = [self genKey:request];
    [self.memoryCache removeObjectForKey:[self cacheRequestFileName:key]];
    [self.memoryCache removeObjectForKey:[self cacheRequestOtherInfoFileName:key]];
    //清除磁盘cache
    NSString *filePath = [self filePathFromRequest:request isInfo:NO];
    NSString *otherInfoFilePath = [self filePathFromRequest:request isInfo:YES];
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:filePath error:nil];
    [fm removeItemAtPath:otherInfoFilePath error:nil];
}
/// 检测缓存容量，超出限制就清除
- (void)checkCapacity {
    if ([self folderSize] > self.diskCapacity) {
        [self clearCache];
    }
}
///接收到内存警告，清除缓存
- (void)handleMemoryWarning {
    [self clearCache];
}
///强制清除缓存
- (void)clearCache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self deleteCacheFolder];
        [self.memoryCache removeAllObjects];
    });
}
///删除缓存文件夹
- (void)deleteCacheFolder {
    [[NSFileManager defaultManager] removeItemAtPath:[self cacheFolderPath] error:nil];
}
///缓存文件大小
- (NSUInteger)folderSize {
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:[self cacheFolderPath] error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDic = [[NSFileManager defaultManager] attributesOfItemAtPath:[[self cacheFolderPath] stringByAppendingPathComponent:fileName] error:nil];
        fileSize += [fileDic fileSize];
    }
    return (NSUInteger)fileSize;
}

#pragma mark - Getter
- (NSString *)diskPath {
    if (!_diskPath) {
        _diskPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    }
    return _diskPath;
}
- (NSString *)cacheFolder {
    if (!_cacheFolder) {
        _cacheFolder = @"com.wsl2ls.webCache";
    }
    return _cacheFolder;
}
- (NSString *)subDirectory {
    if (!_subDirectory) {
        _subDirectory = @"UrlCacheDownload";
    }
    return _subDirectory;
}
- (NSUInteger)memoryCapacity {
    if (!_memoryCapacity) {
        _memoryCapacity = 20 * 1024 * 1024;
    }
    return _memoryCapacity;
}
- (NSUInteger)diskCapacity {
    if (!_diskCapacity) {
        _diskCapacity = 50 * 1024 * 1024;
    }
    return _diskCapacity;
}
- (NSUInteger)cacheTime {
    if (!_cacheTime) {
        _cacheTime = 24 * 60 * 60;
    }
    return _cacheTime;
}
- (void)addWhiteHost:(NSString*)host{
    if (!_whiteListsHost) {
        _whiteListsHost = [NSMutableSet set];
    }
    [_whiteListsHost addObject:host];
}

 
- (void)addBlackHost:(NSString*)host{
    if (!_blackListsHost) {
        _blackListsHost = [NSMutableSet set];
    }
    [_blackListsHost addObject:host];
}
 
- (NSMutableSet *)whiteListsRequestUrl {
    if (!_whiteListsRequestUrl) {
        _whiteListsRequestUrl = [NSMutableSet set];
    }
    return _whiteListsRequestUrl;
}
- (NSString *)whiteUserAgent {
    if (!_whiteUserAgent) {
        _whiteUserAgent = @"";
    }
    return _whiteUserAgent;
}

- (NSMutableDictionary *)responseDic {
    if (!_responseDic) {
        _responseDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _responseDic;
}
- (NSCache *)memoryCache{
    if (!_memoryCache) {
        _memoryCache = [[NSCache alloc] init];
        _memoryCache.delegate = self;
        //缓存空间的最大总成本，超出上限会自动回收对象。默认值为0，表示没有限制
        _memoryCache.totalCostLimit =10;//self.memoryCapacity;
        //能够缓存的对象的最大数量。默认值为0，表示没有限制
        _memoryCache.countLimit = 10;
//        _memoryCache=[YYCache cacheWithName:@"XENGINE_YY_Cache"];
    }
    return _memoryCache;
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
//    NSLog(@"@evicted =>%@", obj);
     
}
@end
