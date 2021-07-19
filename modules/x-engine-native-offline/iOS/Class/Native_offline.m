//
//  Native_offline.m
//  offline
//


#import "Native_offline.h"
#import "XENativeContext.h"

@interface Native_offline()
{ }
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

/// 请求包信息
/// @param url 请求地址
/// return 接口请求的信息
- (NSArray *)getPackagesInfo:(NSString *)url {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
        // 返回数据
    }];
    
    // 启动任务
    [task resume];
    
    return [NSArray array];
}

/// 判断是否需要下载新的应用包
/// @param packageInfo 从后台请求的所有包信息
/// return 返回ture 、false
- (BOOL)judgeIsDownloadNewPackage:(NSDictionary *)packageInfo {
    NSLog(@"%zd", packageInfo.allKeys.count);
    if ([packageInfo isKindOfClass:[NSNull class]] || [packageInfo isEqual:[NSNull null]] || packageInfo.allKeys.count == 0) @throw @"Params==>packageInfo is nil, please check code";

    BOOL isDownload = false;
    if (isDownload) {
        return YES;
    } else {
        return NO;
    }
}
@end
