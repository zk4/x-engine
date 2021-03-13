#import "AppDelegate.h"
#import "XEngineContext.h"
 
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XEngineContext sharedInstance] start];
    [[XEngineContext sharedInstance]  onApplicationDelegate:NSStringFromSelector(_cmd) arg1:application args:launchOptions];
    return YES;
}
 
@end
