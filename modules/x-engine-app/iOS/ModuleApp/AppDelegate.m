#import "AppDelegate.h"
#import "XENativeContext.h"
#import "JSIContext.h"
#import "iOffline.h"
#import "MainTabbarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XENativeContext sharedInstance] start];
    
    [[JSIContext sharedInstance] start];
    
    //  为了看下启动页面图所以延迟1秒
    //  [NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MainTabbarController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [self offinePackage];
    
    return YES;
}


- (void)offinePackage {
    NSString *packageInfoURL = @"https://www.fastmock.site/mock/f9660015182cbe11b416f557de19725c/xengine/api/getMicroappInfo";
    id<iOffline>offline = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iOffline)];
    // 1- 获取应用下所有的包信息
    [offline getPackagesInfo:packageInfoURL completion:^(NSArray *array) {
        // 2- 循环包信息和本地包做判断看是否需要下载
        for (NSDictionary *packageInfo in array) {
            [offline judgeIsDownloadNewPackage:packageInfo completion:^(BOOL isDownload, NSDictionary *dict) {
                // 3- isDownload == YES 下载
                if (isDownload == YES) {
                    [offline downloadNewPackageWithDict:dict];
                }
            }];
        }
    }];
}
@end


