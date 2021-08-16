//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import "XENativeContext.h"
 
// 微信分享相关
NSString * const WX_APPID               = @"wxa11a02e98f71d356";
NSString * const WX_UNIVERSALLINK_APPC  = @"https://app-c.lohashow.com/appc/";

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)configWX {
    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString *log) {
        NSLog(@"WeChatSDK==>\n %@", log);
    }];
    [WXApi registerApp:WX_APPID universalLink:WX_UNIVERSALLINK_APPC];
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configWX];

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    [[XENativeContext sharedInstance] start];

    EntryViewController *homePageVC = [[EntryViewController alloc] init];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
     self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}
  
@end
