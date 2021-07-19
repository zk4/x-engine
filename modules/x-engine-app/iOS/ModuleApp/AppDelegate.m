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
    NSString *packageInfoURL = @"";
    
    id<iOffline>offline = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iOffline)];
    
//    // 1- 获取应用下所有的包信息
    NSArray *allPackageInfoArray = [offline getPackagesInfo:packageInfoURL];

    // 2- 循环包信息和本地包做判断看是否需要下载
    // 2.1 - yes 下载
    // 2.2 - no  不下载
    for (NSDictionary *packageInfo in allPackageInfoArray) {
        if([offline judgeIsDownloadNewPackage:packageInfo]) {
            [offline downloadNewPackage:packageInfo[@"downloadUrl"]];
        } else {
            continue;
        }
    }
}
@end


