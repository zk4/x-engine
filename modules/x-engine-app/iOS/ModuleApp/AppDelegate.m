#import "AppDelegate.h"
#import "XENativeContext.h"
#import "JSIContext.h"

#import "MainTabbarController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XENativeContext sharedInstance] start];
    [[JSIContext sharedInstance] start];
    //  id<iOpenManager> img = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iOpenManager)];
    //  [img open:@"h5" :@"com.gm.microapp.mine" :@"hello" :@{} :0 :FALSE];
    
    //  为了看下启动页面图所以延迟1秒
    //  [NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MainTabbarController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    
    [self offine];
    
    return YES;
}


- (void)offine {
//     x-engine-native-offline modules中的api
//1    - (void)requestPackageInfo { get package info }
//2    - (void)judgePackageVersion:
//3    - (void)downloadPackage:(NSString *)downloadUrl;
//3.1     tips: 断点续传
//4    - (void)unzipPackage:(NSString *)path;
    
//response: -->
//    data:[
//        {
//        // false 不强制更新  ture 强制更新
//        // 不强制更新 ==> 最新的包更新完后不管
//        // 强制更新 ==> 最新的包更新完后就用最新的包刷新页面
//        isForce: false,
//        packageVersion: 0,
//        packageName: "com.gm.microapp.home"
//        downloadUrl:"https://www.baidu.com",
//        },
//        {
//        // false 不强制更新  ture 强制更新
//        // 不强制更新 ==> 最新的包更新完后不管
//        // 强制更新 ==> 最新的包更新完后就用最新的包刷新页面
//        isForce: false,
//        packageVersion: 0,
//        packageName: "com.gm.microapp.home"
//        downloadUrl:"https://www.baidu.com",
//        }
//   ]
    
    
}


@end


