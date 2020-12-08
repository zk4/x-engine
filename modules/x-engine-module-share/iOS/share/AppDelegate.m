//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import <XEngineContext.h>
#import "WXApi.h"
#import "__xengine__module_share.h"
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
    
    [[XEngineContext sharedInstance] start];
    [[XEngineContext sharedInstance]  onApplicationDelegate:NSStringFromSelector(_cmd) arg1:application args:launchOptions];

    EntryViewController *homePageVC = [[EntryViewController alloc] init];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
     self.window.rootViewController = nav;
    
    return YES;
}



- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
//    [[XEngineContext sharedInstance] onApplicationDelegate:NSStringFromSelector(_cmd) arg1:app args:options];
    __xengine__module_share * share= [[XEngineContext sharedInstance] getModuleByName:NSStringFromClass(__xengine__module_share.class)];
   return  [share application:app openURL:url options:options];
}


@end
