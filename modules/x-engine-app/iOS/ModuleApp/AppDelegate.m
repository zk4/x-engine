#import "AppDelegate.h"
#import "XENativeContext.h"
#import "JSIContext.h"

#import "iOffline.h"
#import "MainTabbarController.h"

#import "JumpViewController.h"
#import <Unity.h>
#import <x-engine-native-protocols/iNativeRegister.h>
#import <x-engine-native-core/micros.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XENativeContext sharedInstance] start];
    
    [[JSIContext sharedInstance] start];

    id<iNativeRegister> ir = XENP(iNativeRegister);
    [ir registerNativeRouter:@"native://foo/bar" nativeVCCreator:^UIViewController * _Nullable(NSString * _Nonnull protocol, NSString * _Nonnull host, NSString * _Nonnull pathname, NSString * _Nonnull fragment, NSDictionary * _Nonnull query, NSDictionary * _Nonnull params) {
        return [[JumpViewController alloc] init] ;
    }];

    //  为了看下启动页面图所以延迟1秒
    //  [NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MainTabbarController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    id<iOffline>offline = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iOffline)];
    
//    [offline offlinePackageWithUrl: @"https://www.letonglexue.com/api/test/getTestList"];
    [offline offlinePackageWithUrl: @"http://10.2.128.61:9527/data.json"];
    return YES;
}
@end
