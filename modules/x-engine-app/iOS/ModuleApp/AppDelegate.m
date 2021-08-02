#import "AppDelegate.h"
#import "XENativeContext.h"
#import "JSIContext.h"

#import "iOffline.h"
#import "MainTabbarController.h"

#import "JumpViewController.h"
#import <Unity.h>
#import <x-engine-native-protocols/iNativeRegister.h>
#import <x-engine-native-core/micros.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XENativeContext sharedInstance] start];
    
    [[JSIContext sharedInstance] start];

    id<iNativeRegister> ir = XENP(iNativeRegister);
    [ir registerNativeRouter:@"native://foo/bar" nativeVCCreator:^UIViewController * _Nullable(NSString * _Nonnull protocol, NSString * _Nonnull host, NSString * _Nonnull pathname, NSString * _Nonnull fragment, NSDictionary * _Nonnull query, NSDictionary * _Nonnull params) {
        return [[JumpViewController alloc] init] ;
    }];

    //  为了看下启动页面图所以延迟1秒
    //  [NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MainTabbarController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    id<iOffline>offline = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iOffline)];
    
    [offline offlinePackageWithUrl: @"https://www.letonglexue.com/api/test/getTestList"];
    
    return YES;
}

@end





//- (void)offinePackage {
//    id<iOffline>offline = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iOffline)];
//
//    // 启动应用后读取packageInfo.json的信息 写入document长久持有 已做后续更新内容的依据
//    // 如果路径下没有 写入
//    // 如果路径下已有 不在操作
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *packageInfoPath = [documentPath stringByAppendingPathComponent:@"packageInfo.json"];
//    if(![[NSFileManager defaultManager] fileExistsAtPath:packageInfoPath]) {
//        [offline saveProjectMicroappInfo:[offline getRootPackageJsonInfo]];
//    }
//
//    NSString *packageInfoURL = @"https://www.letonglexue.com/api/test/getTestList";
//    // 1- 获取应用下所有的包信息
//    [offline getPackagesInfo:packageInfoURL completion:^(NSArray *array) {
//        // 2- 循环包信息和本地包做判断看是否需要下载
//        for (NSDictionary *packageInfo in array) {
//            [offline judgeIsDownloadNewPackage:packageInfo completion:^(BOOL isDownload, NSDictionary *dict) {
//                // 3- isDownload == YES 下载
//                if (isDownload == YES) {
//                    [offline downloadNewPackageWithDict:dict];
//                }
//            }];
//        }
//    }];
//}
