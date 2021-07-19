//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import "EntryViewController2.h"

#import "XENativeContext.h"
#import "MGJRouter.h"
#import <x-engine-native-core/Unity.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    [[XENativeContext sharedInstance] start];

    [MGJRouter registerURLPattern:@"native://foo/bar" toHandler:^(NSDictionary *routerParameters) {
        NSLog(@"routerParameterUserInfo:%@", routerParameters[MGJRouterParameterUserInfo]);
 
        [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:[[EntryViewController alloc] init] animated:TRUE];
         
    }];
    [MGJRouter registerURLPattern:@"native://foo/bar2" toHandler:^(NSDictionary *routerParameters) {
        NSLog(@"routerParameterUserInfo:%@", routerParameters[MGJRouterParameterUserInfo]);
 
        [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:[[EntryViewController2 alloc] init] animated:TRUE];
         
    }];

    EntryViewController *homePageVC = [[EntryViewController alloc] init];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
     self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}
  
@end
