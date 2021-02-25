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
    EntryViewController *home1 = [[EntryViewController alloc] init];
    EntryViewController *home2 = [[EntryViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    nav.tabBarItem.title = @"首页";
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:home1];
    nav1.tabBarItem.title = @"2ye";
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:home2];
    nav2.tabBarItem.title = @"3ye";
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    tabbar.viewControllers = @[nav,nav1,nav2];
    
    self.window.rootViewController = tabbar;
    return YES;
}
@end
