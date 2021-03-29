#import "AppDelegate.h"
#import "NativeContext.h"
#import "JSIContext.h"
#import "MainNavigationController.h"
#import "MainTabbarController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NativeContext sharedInstance] start];
    [[JSIContext sharedInstance] start];
//    id<iOpenManager> img = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iOpenManager)];
//    [img open:@"h5" :@"com.gm.microapp.mine" :@"hello" :@{} :0 :FALSE];
    
    // 为了看下启动页面图所以延迟1秒
//    [NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MainTabbarController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
 
@end
