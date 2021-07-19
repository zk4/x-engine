#import "AppDelegate.h"
#import "XENativeContext.h"
#import "JSIContext.h"
#import "MGJRouter.h"
#import "MainTabbarController.h"
#import "JumpViewController.h"
#import <Unity.h>
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XENativeContext sharedInstance] start];
    [[JSIContext sharedInstance] start];
    
    [MGJRouter registerURLPattern:@"native://foo/bar" toHandler:^(NSDictionary *routerParameters) {
        NSLog(@"routerParameterUserInfo:%@", routerParameters[MGJRouterParameterUserInfo]);
 
        [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:[[JumpViewController alloc] init] animated:TRUE];
         
    }];
    
//  id<iOpenManager> img = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iOpenManager)];
//  [img open:@"h5" :@"com.gm.microapp.mine" :@"hello" :@{} :0 :FALSE];
    
//  为了看下启动页面图所以延迟1秒
//  [NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MainTabbarController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    

    return YES;
}
 
@end
