//
//  AppDelegate.m
//  iOS
//
//  Created by edz on 2020/7/22.
//  Copyright © 2020 edz. All rights reserved.
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import <XEngineContext.h>
@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XEngineContext sharedInstance] start];
    [[XEngineContext sharedInstance]  onApplicationDelegate:NSStringFromSelector(_cmd) arg1:application args:launchOptions];
    EntryViewController *homePageVC = [[EntryViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    self.window.rootViewController = nav;
    return YES;
}
@end
