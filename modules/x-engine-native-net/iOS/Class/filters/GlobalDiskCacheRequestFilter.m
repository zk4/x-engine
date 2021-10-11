//
//  GlobalDiskCacheRequestFilter.m
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 x-engine. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE./

#import "GlobalDiskCacheRequestFilter.h"
#import <CommonCrypto/CommonDigest.h>

@interface GlobalDiskCacheRequestFilter()
/// 磁盘缓存容量 默认50M
@property (nonatomic, assign) NSUInteger diskCapacity;
/// 缓存的有效时长(s)  默认 24 * 60 * 60 一天 ，如果为0，表示永久有效，除非手动强制删除，否则有缓存之后，只从缓存读取
@property (nonatomic, assign) NSUInteger cacheTime;
/// 磁盘路径 默认 NSCachesDirectory
@property (nonatomic, copy) NSString *diskPath;
/// 缓存文件夹 默认 @"com.wsl2ls.webCache"
@property (nonatomic, copy) NSString *cacheFolder;
/// 子路径 默认 @"UrlCacheDownload"
@property (nonatomic, copy) NSString *subDirectory;
@end
@implementation GlobalDiskCacheRequestFilter
+ (id)sharedInstance
{
    static GlobalDiskCacheRequestFilter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)response chain:(id<iKOFilterChain>) chain {
     
        [chain doFilter:session request:request response:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            response(data,res,error);
        }];
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
    return [GlobalDiskCacheRequestFilter md5Hash:[NSString stringWithFormat:@"%@",requestUrl]];
}
///缓存其他信息的文件名
- (NSString *)cacheRequestOtherInfoFileName:(NSString *)requestUrl {
    return [GlobalDiskCacheRequestFilter md5Hash:[NSString stringWithFormat:@"%@-otherInfo",requestUrl]];
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

- (nonnull NSString *)name {
    return @"全局 disk cache 请求 filter";
}

@end
