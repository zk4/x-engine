//
//  Native_offline.m
//  offline
//


#import "Native_offline.h"
#import "XENativeContext.h"
//#import <ZipArchive.h>
#import "ZipArchive.h"

@interface Native_offline() <NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionTask *dataTask;
@property (nonatomic, strong) NSDictionary *saveDownloadInfo;
@end

@implementation Native_offline
NATIVE_MODULE(Native_offline)

- (NSString *)moduleId {
    return @"com.zkty.native.offline";
}

- (int)order {
    return 0;
}

- (void)afterAllNativeModuleInited{
    
}

- (NSDictionary *)saveDownloadInfo {
    if (!_saveDownloadInfo) {
        _saveDownloadInfo = [NSDictionary dictionary];
    }
    return _saveDownloadInfo;
}

/// 请求接口获取最新的microapp信息
/// @param url 请求地址
/// @param arrayBlock responseblock
- (void)getPackagesInfo:(NSString *)url completion:(void (^)(NSArray *))arrayBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data==nil) {
            NSLog(@"request data is nil, please check code");
            return;
        } else {
            NSError* error1;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
            NSLog(@"像后端请求过来的数据==>%@", json);
            NSArray *microappInfoArray = [json objectForKey:@"data"];
            if(arrayBlock) {
                arrayBlock(microappInfoArray);
            }
        }
    }];
    // 启动任务
    [task resume];
}

/// 判断是否需要下载新的应用包
/// @param packageInfo 从后台请求的所有包信息
/// return 返回ture 、false
- (void)judgeIsDownloadNewPackage:(NSDictionary *)packageInfo completion:(void (^)(BOOL, NSDictionary *dict))isDownloadBlock {
    if ([packageInfo isKindOfClass:[NSNull class]] || [packageInfo isEqual:[NSNull null]] || packageInfo.allKeys.count == 0) @throw @"Params==>packageInfo is nil, please check code";
    
    NSArray *localMicroappJsonInfo = [self getLocalMicroappJsonInfo];
    [self contrastLocalMicroAppData:localMicroappJsonInfo withNewMicroappData:packageInfo completion:^(BOOL block, NSDictionary *newDict) {
        isDownloadBlock(block, newDict);
    }];
}

/// 读取本地microapp.json的内容
- (NSArray *)getLocalMicroappJsonInfo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"microapp" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *array = dict[@"packagesInfo"];
    return array;
}

/// 本地和返回的数据做对比
- (void)contrastLocalMicroAppData:(NSArray *)localMicroappInfoArray withNewMicroappData:(NSDictionary *)newMicroappInfoDict completion:(void (^)(BOOL, NSDictionary*))block {
    NSString *newMicroappName = newMicroappInfoDict[@"name"];
    int newVersion = [newMicroappInfoDict[@"version"] intValue];
    for (NSDictionary *localDict in localMicroappInfoArray) {
        if ([localDict[@"name"] isEqualToString:newMicroappName]) {
            if (newVersion > [localDict[@"version"] intValue]) {
                NSLog(@"%@、需要下载", newMicroappInfoDict[@"name"]);
                // 保存传入的下载microappInfo 为之后 更新本地microapp.json用
                _saveDownloadInfo = newMicroappInfoDict;
                if (block) {
                    block(YES, newMicroappInfoDict);
                }
            } else {
                if (block) {
                    block(NO, newMicroappInfoDict);
                }
                NSLog(@"%@、不需要下载", newMicroappInfoDict[@"name"]);
            }
        }
    }
}

// 下载新的package
- (void)downloadNewPackageWithDict:(NSDictionary *)dict {
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
    // 请求超时时间
    sessionConfig.timeoutIntervalForRequest = 5.0f;
    // 是否允许蜂窝网络下载
    sessionConfig.allowsCellularAccess = true;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDownloadTask *dataTask = [session downloadTaskWithURL:[NSURL URLWithString:dict[@"downloadUrl"]]];
    [dataTask resume];
}

#pragma mark - <NSURLSessionDownloadDelegate>
/**
 * 每当写入数据到临时文件时，就会调用一次这个方法
 * totalBytesExpectedToWrite:总大小
 * totalBytesWritten: 已经写入的大小
 * bytesWritten: 这次写入多少
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"--------%f", 1.0 * totalBytesWritten / totalBytesExpectedToWrite);
}

// 下载完毕就会调用一次这个方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    // caches path
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 下载后的文件名称
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    // 将临时文件move到Caches文件夹
    // AtPath : 剪切前的文件路径  ToPath : 剪切后的文件路径
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:file error:nil];
    
    // document path
    NSString *documentPath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSMutableString *string = [NSMutableString stringWithString:filePath];
    NSString *desPath =  [string substringToIndex:string.length - 4];
    
    // 解压
    [SSZipArchive unzipFileAtPath:file toDestination:desPath];
    
    // 同步本地的microapp.json
    [self syncLocalMicroappJson];
}

// 同步本地microapp.json
- (void)syncLocalMicroappJson {
    // 想好添加plist的时机, 所有逻辑从plist读取microapp的包信息
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"packageInfo.plist"];
    NSLog(@"%@", filePath);
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"packageInfo" ofType:@"text"];
//    NSLog(@"%@", path);
//
//    NSData *jsonData1 = [[NSFileManager defaultManager] contentsAtPath:path];
//    NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:jsonData1 options:1 error:nil];
//    NSLog(@"%@", dict1);
//
//    NSArray *array = @[@1, @2, @3];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:array,@"1",@"dongdong", @"name", nil];
//    NSLog(@"%@", dic);
//
//    //首先判断能否转化为一个json数据，如果能，接下来先把foundation对象转化为NSData类型，然后写入文件
//    if ([NSJSONSerialization isValidJSONObject:dic]) {
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:1 error:nil];
//        [jsonData writeToFile:path atomically:YES];
//    }
//
//    在读取的时候首先去文件中读取为NSData类对象，然后通过NSJSONSerialization类将其转化为foundation对象
//        NSData *jsonData = [[NSFileManager defaultManager] contentsAtPath:path];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:1 error:nil];
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    NSMutableArray *array = dict[@"packagesInfo"];
    
//    for (NSDictionary *dict in array) {
//        if ([dict[@"name"] isEqualToString:_saveDownloadInfo[@"name"]]) {
//            NSString *str = [self dictionaryToJson:_saveDownloadInfo];
//            BOOL s = [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
//            NSLog(@"%d", s);
//            if ([NSJSONSerialization isValidJSONObject:_saveDownloadInfo]) {
//                NSOutputStream *outStream = [[NSOutputStream alloc] initToFileAtPath:path append:YES];
//                [outStream open];
//                // 执行写入方法，并接收写入的数据量
//                NSError *error;
//                NSInteger length = [NSJSONSerialization writeJSONObject:_saveDownloadInfo toStream:outStream options:NSJSONWritingPrettyPrinted error:&error];
//                NSLog(@"json可以写入");
//                NSLog(@"write %ld bytes",(long)length);
//                // 关闭数据流， 写入完成
//                [outStream close];
//            } else {
//                NSLog(@"json不可以写入");
//            }
                
            
            
//        } else {
//            NSLog(@"0000");
//        }
//    }
}

// 下载错误会来到这个方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"didCompleteWithError ==> %@", error);
}

// 断点下载(中途取消,或者退出)会来到这个方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"didResumeAtOffset");
}

//字典转json格式字符串:
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
