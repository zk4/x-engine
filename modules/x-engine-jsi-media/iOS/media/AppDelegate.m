//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import "XENativeContext.h"
#import "JSIContext.h"
#import "PLeakSniffer.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
+ (void)load
{
    // 有意思, 像 java
    NSLog(@"hello ,world");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[XENativeContext sharedInstance] start];
    [[JSIContext sharedInstance] start];
    
    [[PLeakSniffer sharedInstance] installLeakSniffer];
    [[PLeakSniffer sharedInstance] addIgnoreList:@[]];
    
    EntryViewController *homePageVC = [[EntryViewController alloc] init];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
     self.window.rootViewController = nav;
    
    return YES;
}
  
@end
