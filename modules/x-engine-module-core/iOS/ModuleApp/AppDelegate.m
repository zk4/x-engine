#import "AppDelegate.h"
#import "XEngineContext.h"
#import "MicroAppContext.h"
#import "iOpenManager.h"
#import "MainNavigationController.h"
#import "MainTabbarController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XEngineContext sharedInstance] start];
    [[MicroAppContext sharedInstance] start];
    id<iOpenManager> img = [[XEngineContext sharedInstance] getModuleByProtocol:@protocol(iOpenManager)];
    [img open:@"native" :@"hello" :@"hello" :@{} :0 :FALSE];
    [img open:@"h5" :@"hello" :@"hello" :@{} :0 :FALSE];
    
    // 为了看下启动页面图所以延迟1秒
    [NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MainTabbarController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
 
@end
