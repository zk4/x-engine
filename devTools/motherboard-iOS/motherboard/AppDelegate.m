//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import <XEngineContext.h>
#import "ZYDL_TabBarController.h"
#import "DCUniMP.h"
#import "WeexSDK.h"
#import "__xengine__module_dcloud.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
+ (void)load
{
    // 有意思, 像 java
    NSLog(@"hello ,world");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[__xengine__module_dcloud shareInstance] application:application didFinishLaunchingWithOptions:launchOptions];

    [[XEngineContext sharedInstance] start];
    [[XEngineContext sharedInstance]  onApplicationDelegate:NSStringFromSelector(_cmd) arg1:application args:launchOptions];

    EntryViewController *homePageVC = [[EntryViewController alloc] init];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];

     self.window.rootViewController = [[ZYDL_TabBarController alloc] init];
    
    
    return YES;
}

#pragma mark - App 生命周期方法
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationWillTerminate:application];
}
  
@end
