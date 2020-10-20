//
//  AppDelegate+XEngineTabBar.h
//  XEngineApp
//
//  Created by 李国阳 on 2020/7/27.
//  Copyright © 2020 edz. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (XEngineTabBar)<UITabBarControllerDelegate>
// TabBar上 当前正在使用的NavigationController
@property (nonatomic, readonly) UINavigationController *wantedNavigationController;

// TabBar上 当前正在使用的NavigationController的topViewController
@property (nonatomic, readonly) UIViewController *topViewController;

- (void)useXEngineTabBar;

@end

NS_ASSUME_NONNULL_END
