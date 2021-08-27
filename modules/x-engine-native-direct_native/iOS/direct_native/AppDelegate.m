//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import "EntryViewController2.h"

#import "XENativeContext.h"
 
#import <x-engine-native-core/Unity.h>
#import <iNativeRegister.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    [[XENativeContext sharedInstance] start];

    id<iNativeRegister> dm = XENP(iNativeRegister);
    
    
    [dm registerNativeRouter:@"native://foo/bar2" nativeVCCreator:^UIViewController * _Nullable(NSString * _Nonnull protocol, NSString * _Nonnull host, NSString * _Nonnull pathname, NSString * _Nonnull fragment, NSDictionary * _Nonnull query, NSDictionary * _Nonnull params) {
        return [[EntryViewController alloc] init];
    }];

    EntryViewController *homePageVC = [[EntryViewController alloc] init];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
     self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}
  
@end
