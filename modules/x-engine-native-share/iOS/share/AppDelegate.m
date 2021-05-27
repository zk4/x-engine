//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import "NativeContext.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    [[NativeContext sharedInstance] start];

    EntryViewController *homePageVC = [[EntryViewController alloc] init];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
     self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}
  
@end
