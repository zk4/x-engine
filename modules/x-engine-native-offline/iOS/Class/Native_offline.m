//
//  Native_offline.m
//  offline
//


#import "Native_offline.h"
#import "XENativeContext.h"
#import "ZipArchive.h"

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

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

// lazy
- (NSDictionary *)saveDownloadInfo {
    if (!_saveDownloadInfo) {
        _saveDownloadInfo = [NSDictionary dictionary];
    }
    return _saveDownloadInfo;
}

// lazy
- (NSMutableDictionary *)saveResponseMicroappInfo {
    if (!_saveResponseMicroappInfo) {
        _saveResponseMicroappInfo = [NSMutableDictionary dictionary];
    }
    return  _saveResponseMicroappInfo;
}

/*
 * 启动应用后读取packageInfo.json的信息 写入沙盒 已做后续更新内容的依据
 * 如果路径下没有 写入
 * 如果路径下已有 不在操作
 */
- (void)afterAllNativeModuleInited {
    NSString *packageInfoPath = [kDocumentPath stringByAppendingPathComponent:@"packageInfo.json"];
    NSLog(@"packageInfoPath==>%@", packageInfoPath);
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:packageInfoPath]) {
        [self saveProjectMicroappInfo:[self getRootPackageJsonInfo]];
    } else {
        NSLog(@"有packageInfo.json, 不执行任何操作");
    }
}

/**
 * 离线包
 * @url 请求后台地址
 */
- (void)offlinePackageWithUrl:(NSString *)url {
    // 1. 请求后台最新的包信息
    [self getPackagesInfo:url completion:^(NSArray *array) {
        // 2- 循环包信息和本地包做判断看是否需要下载
        for (NSDictionary *packageInfo in array) {
            [self judgeIsDownloadNewPackage:packageInfo completion:^(BOOL isDownload, NSDictionary *dict) {
                // 3- isDownload == YES 下载
                if (isDownload == YES) {
                    [self downloadNewPackageWithDict:dict];
                }
            }];
        }
    }];
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
            NSArray *microappInfoArray = [json objectForKey:@"data"];
            self.saveResponseMicroappInfo = nil;
            [self.saveResponseMicroappInfo setObject:microappInfoArray forKey:@"data"];
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
 * @param session          会话对象
 * @param downloadTask       下载任务
 * @param bytesWritten       本次写入的数据大小
 * @param totalBytesWritten     下载的数据总大小
 * @param totalBytesExpectedToWrite 文件的总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    //下载进度
    double downloadProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    NSString *progressStr = [NSString stringWithFormat:@"%.1f", downloadProgress * 100];
    progressStr = [progressStr stringByAppendingString:@"%"];
    NSLog(@"progressStr==>%@", progressStr);
    
    
    //下载进度
//    NSLog(@"%f",1.0 * totalBytesWritten/totalBytesExpectedToWrite);
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
    NSString *filePath = [kDocumentPath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSMutableString *string = [NSMutableString stringWithString:filePath];
    NSString *desPath =  [string substringToIndex:string.length - 4];
    
    // 解压到document下
    [SSZipArchive unzipFileAtPath:file toDestination:desPath progressHandler:nil completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            NSString *packageInfoPath = [kDocumentPath stringByAppendingPathComponent:@"packageInfo.json"];
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
 * 第一次打开应用调用的方法 如果ducument下已有packageInfo.json 将不在调用
 * 读取本地packageInfo.json的内容
 */
- (NSDictionary *)getRootPackageJsonInfo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"microapp" ofType:@""];
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    NSMutableArray *saveArr = [NSMutableArray array];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *str = [NSString stringWithFormat:@"/%@/microapp.json", arr[i]];
        NSString *microappJsonPath = [path stringByAppendingString:str];
        NSData *data = [[NSData alloc] initWithContentsOfFile:microappJsonPath];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        [saveArr insertObject:dict atIndex:0];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"data"] = saveArr;
    return dict;
}

/**
 * 将项目下的microoapp信息存入document的packageInfo中
 * @array all microapp 集合
 */
- (void)saveProjectMicroappInfo:(NSDictionary *)dict {
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        NSString *packageInfoPath = [kDocumentPath stringByAppendingPathComponent:@"packageInfo.json"];
        NSOutputStream *outStream = [[NSOutputStream alloc] initToFileAtPath:packageInfoPath append:NO];
        [outStream open];
        NSError *error;
        NSInteger length = [NSJSONSerialization writeJSONObject:dict toStream:outStream options:NSJSONWritingPrettyPrinted error:&error];
        if (length != 0) {
            [outStream close];
            NSLog(@"packageInfo.json==>写入成功%@", packageInfoPath);
        } else {
            NSLog(@"packageInfo.json==>%@", error);
        }
    } else {
        NSLog(@"packageInfo.json无法写入==>(dict不可用)");
    }
}

/**
 * 从document的packageInfo中读取存入的microoapp信息
 * return all microapp info
 */
- (NSDictionary *)getProjectMicroappInfo {
    NSString *packageInfoPath = [kDocumentPath stringByAppendingPathComponent:@"packageInfo.json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:packageInfoPath];
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


/************************************暂时不用, 保留方法*****************************************/
/**
 * 暂时不用, 保留方法
 * 获取微应用包地址
 * @packageName: 需要加载包名称
 */
//- (NSString *)getPackageWithPackageName:(NSString *)packageName {
//    NSArray *array = [self getProjectMicroappInfo][@"data"];
//    NSString *filePath = [NSString string];
//    for (NSDictionary *dict in array) {
//        NSString *name = [NSString stringWithFormat:@"%@", dict[@"name"]];
//        if ([name isEqualToString:packageName]) {
//            NSString *name = dict[@"name"];
//            NSString *version = [NSString stringWithFormat:@"%@", dict[@"version"]];
//            NSString *packageName = [NSString stringWithFormat:@"%@.%@", name,version];
//            filePath = [NSString stringWithFormat:@"%@/%@", kDocumentPath, packageName];
//        }
//    }
//    return filePath;
//}


/**
 ** 暂时不用, 保留方法
 * 获取本地地址包地址
 * @index 传入对应索引
 */
//- (NSMutableDictionary *)getFilePathWithIndex:(int)index {
//    NSArray *array = [self getProjectMicroappInfo][@"data"];
//    NSDictionary *dict = array[index];
//    NSString *name = dict[@"name"];
//    NSString *version = [NSString stringWithFormat:@"%@", dict[@"version"]];
//    NSString *packageName = [NSString stringWithFormat:@"%@.%@", name,version];
//    NSString *documentPath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentPath, packageName];
//    NSMutableDictionary *localDict = [NSMutableDictionary dictionary];
//    localDict[@"name"] = name;
//    localDict[@"filePath"] = filePath;
//    return localDict;
//}

/**
 * 获取根目录下所有的microapp
 */
//- (NSDictionary *)getRootPackageJsonInfo {
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"packageInfo" ofType:@"json"];
//    NSLog(@"%@", path);
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    return dict;
//}

/**
 * 第一次打开应用调用的方法 如果ducument下已有packageInfo.json 将不在调用
 * 读取本地packageInfo.json的内容
 */
//- (NSDictionary *)getRootPackageJsonInfo {
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"packageInfo" ofType:@"json"];
//    NSLog(@"%@", path);
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    return dict;
//}
@end
