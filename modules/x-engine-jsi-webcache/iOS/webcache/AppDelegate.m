//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import "XENativeContext.h"
#import "JSIContext.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[XENativeContext sharedInstance] start];
    [[JSIContext sharedInstance] start];

    EntryViewController *homePageVC = [[EntryViewController alloc] init];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
     self.window.rootViewController = nav;
    
    return YES;
}
  
@end
