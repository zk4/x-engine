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
@property (nonatomic, strong) NSMutableDictionary *saveResponseMicroappInfo;
@end

@implementation Native_offline
NATIVE_MODULE(Native_offline)

- (NSString *)moduleId {
    return @"com.zkty.native.offline";
}

- (int)order {
    return 0;
}

- (void)afterAllNativeModuleInited{}

/*
 * lazy
 */
- (NSDictionary *)saveDownloadInfo {
    if (!_saveDownloadInfo) {
        _saveDownloadInfo = [NSDictionary dictionary];
    }
    return _saveDownloadInfo;
}

- (NSMutableDictionary *)saveResponseMicroappInfo {
    if (!_saveResponseMicroappInfo) {
        _saveResponseMicroappInfo = [NSMutableDictionary dictionary];
    }
    return _saveResponseMicroappInfo;
}

/**
 * 请求包信息
 * @param url 请求地址
 * return 接口请求的信息
 */
- (void)getPackagesInfo:(NSString *)url completion:(void (^)(NSArray *))arrayBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data == nil) {
            NSLog(@"request data is nil, please check code");
            return;
        } else {
            NSError* error1;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
            NSLog(@"后端请求过来的数据==>%@", json);
            NSArray *microappInfoArray = [json objectForKey:@"data"];
            self.saveResponseMicroappInfo = nil;
            [self.saveResponseMicroappInfo setObject:microappInfoArray forKey:@"data"];
            NSLog(@"saveResponseMicroappInfo==>\n%@", self.saveResponseMicroappInfo);
            if(arrayBlock) {
                arrayBlock(microappInfoArray);
            }
        }
    }];
    [task resume];
}

/**
 *  判断是否需要下载新的应用包
 *  @param packageInfo 从后台请求的所有包信息
 *  return 返回ture 、false
 */
- (void)judgeIsDownloadNewPackage:(NSDictionary *)packageInfo completion:(void (^)(BOOL, NSDictionary *dict))isDownloadBlock {
    if ([packageInfo isKindOfClass:[NSNull class]] || [packageInfo isEqual:[NSNull null]] || packageInfo.allKeys.count == 0) @throw @"Params==>packageInfo is nil, please check code";
    NSDictionary *dict = [self getProjectMicroappInfo];
    NSArray *localMicroappJsonInfo = dict[@"data"];
    [self contrastLocalMicroAppData:localMicroappJsonInfo withNewMicroappData:packageInfo completion:^(BOOL block, NSDictionary *newDict) {
        isDownloadBlock(block, newDict);
    }];
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


/**
 * 下载新的应用包
 *  @param dict 当前应用包的信息
 */
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
    
    // 解压到document下
    [SSZipArchive unzipFileAtPath:file toDestination:desPath progressHandler:nil completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *packageInfoPath = [documentPath stringByAppendingPathComponent:@"packageInfo.json"];
            if([[NSFileManager defaultManager] fileExistsAtPath:packageInfoPath]) {
                [[NSFileManager defaultManager] removeItemAtPath:packageInfoPath error:nil];
                // 同步本地document下的packageInfo.json
                [self saveProjectMicroappInfo:self.saveResponseMicroappInfo];
            }
        } else {
            NSLog(@"解压失败==>%@", error);
        }
    }];
}

// 下载错误会来到这个方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"didCompleteWithError ==> %@", error);
}

// 断点下载(中途取消,或者退出)会来到这个方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"didResumeAtOffset");
}

/**************************************util**************************************/
/**
 * 获取本地地址包地址
 * @index 传入对应索引
 */
- (NSMutableDictionary *)getFilePathWithIndex:(int)index {
    NSArray *array = [self getProjectMicroappInfo][@"data"];
    NSDictionary *dict = array[index];
    NSString *name = dict[@"name"];
    NSString *version = [NSString stringWithFormat:@"%@", dict[@"version"]];
    NSString *packageName = [NSString stringWithFormat:@"%@.%@", name,version];
    NSString *documentPath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentPath, packageName];
    NSMutableDictionary *localDict = [NSMutableDictionary dictionary];
    localDict[@"name"] = name;
    localDict[@"filePath"] = filePath;
    return localDict;
}

/**
 * 将项目下的microoapp信息存入document的packageInfo中
 * @array all microapp 集合
 */
- (void)saveProjectMicroappInfo:(NSDictionary *)dict {
    NSString *documentPath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *packageInfoPath = [documentPath stringByAppendingPathComponent:@"packageInfo.json"];
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        NSOutputStream *outStream = [[NSOutputStream alloc] initToFileAtPath:packageInfoPath append:YES];
        [outStream open];
        NSError *error;
        NSInteger length = [NSJSONSerialization writeJSONObject:dict toStream:outStream options:NSJSONWritingPrettyPrinted error:&error];
        if (length != 0) {
            [outStream close];
            NSLog(@"packageInfo.json写入成功");
        } else {
            NSLog(@"packageInfo.json==>%@", error);
        }
    } else {
        NSLog(@"packageInfo.json无法写入");
    }
}

/**
 * 从document的packageInfo中读取存入的microoapp信息
 * return all microapp info
 */
- (NSDictionary *)getProjectMicroappInfo {
    NSString *documentPath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *packageInfoPath = [documentPath stringByAppendingPathComponent:@"packageInfo.json"];
    NSLog(@"packageInfoPath==>\n%@", packageInfoPath);
    NSData *data = [[NSData alloc] initWithContentsOfFile:packageInfoPath];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return dict;
}

/**
 * 第一次打开应用调用的方法 如果ducument下已有packageInfo.json 将不在调用
 * 读取本地packageInfo.json的内容
 */
- (NSDictionary *)getRootPackageJsonInfo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"packageInfo" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return dict;
}

/*
 * 字典转json格式字符串:
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dict {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
