//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import <XEngineContext.h>
//#ifdef DEBUG
//#import <DoraemonKit/DoraemonManager.h>
//#endif


@interface AppDelegate ()

@end
   
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[XEngineContext sharedInstance] start];
    [[XEngineContext sharedInstance]  onApplicationDelegate:NSStringFromSelector(_cmd) arg1:application args:launchOptions];

    EntryViewController *homePageVC = [[EntryViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
     self.window.rootViewController = nav;
//    #ifdef DEBUG
//      [[DoraemonManager shareInstance] install];
//      #endif

    
    return YES;
}





@end
