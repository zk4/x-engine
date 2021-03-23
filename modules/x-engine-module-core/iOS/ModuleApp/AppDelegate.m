#import "AppDelegate.h"
#import "XEngineContext.h"
#import "MicroAppContext.h"
#import "iOpenManager.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XEngineContext sharedInstance] start];
    [[MicroAppContext sharedInstance] start];
    id<iOpenManager> img = [[XEngineContext sharedInstance] getModuleByProtocol:@protocol(iOpenManager)];
    [img open:@"native" :@"hello" :@"hello" :@{} :0 :FALSE];
    [img open:@"h5" :@"hello" :@"hello" :@{} :0 :FALSE];

    return YES;
}
 
@end
