//
//  Native_offline.m
//  offline
//


#import "Native_offline.h"
#import "XENativeContext.h"

#define DocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

@interface Native_offline() <NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionTask *dataTask;
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

/// 请求接口获取最新的microapp信息
/// @param url 请求地址
/// @param arrayBlock responseblock
- (void)getPackagesInfo:(NSString *)url completion:(void (^)(NSArray *))arrayBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError* error1;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error1];
        NSArray *microappInfoArray = [json objectForKey:@"data"];
        if(arrayBlock) {
            arrayBlock(microappInfoArray);
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
                NSLog(@"需要下载");
                if (block) {
                    block(YES, newMicroappInfoDict);
                }
            } else {
                if (block) {
                    block(NO, newMicroappInfoDict);
                }
                NSLog(@"不需要下载");
            }
        }
    }
}


// 下载新的package
- (void)downloadNewPackageWithDict:(NSDictionary *)dict {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDownloadTask *dataTask = [session downloadTaskWithURL:[NSURL URLWithString:@"http://127.0.0.1:8000/com.gm.microapp.home.1.zip"]];
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

////////////////////////////////////////todo 待做下载后移到document文件夹下
// 下载完毕就会调用一次这个方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
//    NSLog(@"%@", location);
//
//    // 文件将来存放的真实路径
//    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
//    NSLog(@"%@", downloadTask.response);
//    NSLog(@"%@", downloadTask.response.suggestedFilename);
//    NSLog(@"%@", file);
////
//    NSLog(@"%@", DocumentPath);
//    // 剪切location的临时文件到真实路径
//    NSFileManager *mgr = [NSFileManager defaultManager];
//    [mgr moveItemAtURL:location toURL:[NSURL fileURLWithPath:file] error:nil];
}

// 下载错误会来到这个方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"didCompleteWithError ==> %@", error);
}

// 断点下载(中途取消,或者退出)会来到这个方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"didResumeAtOffset");
}
@end
