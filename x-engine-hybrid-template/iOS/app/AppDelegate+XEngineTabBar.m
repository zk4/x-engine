//
//  AppDelegate+XEngineTabBar.m
//  XEngineApp
//
//  Created by 李国阳 on 2020/7/27.
//  Copyright © 2020 edz. All rights reserved.
//

#import "AppDelegate+XEngineTabBar.h"
#import "XEngine.h"
#import <MircroAppController.h>

@implementation AppDelegate (XEngineTabBar)
- (void)useXEngineTabBar
{
    [self setupWindow];
    [self setupViewController];
}
- (void)setupWindow
{
    self.window.backgroundColor = [UIColor whiteColor];
    
#if 1
    [[UINavigationBar global] setColor:UIColor.whiteColor];
    [[UINavigationBar global] setTitleColor:[UIColor colorWithHexString:@"333333"]];
    [[UINavigationBar global] setTitleFont:[UIFont boldSystemFontOfSize:18.0]];
    
    [[UINavigationItem global] setBarButtonItemColor:[UIColor blackColor]];
    [[UINavigationItem global] setBarButtonItemFont:[UIFont systemFontOfSize:16.0]];

    [[UIViewController global] setLoadingPromptTheme:LoadingPromptThemeDark];
    
    [UIViewController.global setLoadingPromptCornerRadius:8.0];
    [UIViewController.global setLoadingPromptMargin:25.0];
    [NavigationController.global setNavigationBarTranslucent:YES];
    
    
#else
#endif
    
}

- (void)setupViewController
{
    UIViewController *viewController = nil;
    // 直接进入
    viewController = [self createTabBarController];
    // 新版本有可能要展示向导
//    if (![USER_DEFAULT objectForKey:@"version"] || [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"] > [USER_DEFAULT objectForKey:@"version"] )
//    {
//        viewController = [self setupIntroductionViewController];
//    }
//    else
//    {
//        // 直接进入
//        viewController = [self createTabBarController];
//    }
    
    // 首次设置rootViewController时，加一个过渡动画
    [self updateRootViewController:viewController animated:NO];
   
}



- (TabBarController *)createTabBarController
{

    MircroAppController *webVC0 = [[MircroAppController alloc] initWithMicroAppId:@"com.zkty.xiaoqu.network" microAppVersion:@"0" ];
    MircroAppController *webVC1 = [[MircroAppController alloc] initWithMicroAppId:@"com.zkty.xiaoqu.nav" microAppVersion:@"0" ];
//    WebFileUrlViewController *webVC2 = [[WebFileUrlViewController alloc] initWithMicroAppId:@"com.zkty.xengine.navigator" microAppVersion:@"4" index:0];
    

    NavigationControllerConstructor ncc = ^(UINavigationController **nc, UIViewController *vc) {
        
        if (vc.navigationController) {
            *nc = vc.navigationController;
            
        }
        else
        {
            NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:vc];
            navigationController.customizedNavigationBarTranslucent = YES;
//            navigationController.view.backgroundColor = [UIColor yellowColor];
            
            *nc = navigationController;
       
        }
    };
    
    TabBarController *tabVC = [[TabBarController alloc] init];
//    TabBarController *tabVC = [[TabBarController alloc] init];
    tabVC.delegate = self;
//    tabVC.tabBar.translucent = NO;
//    [UITabBar appearance].translucent = NO;
//    tabVC.tabBar.translucent = NO;
    tabVC.autorotateEnabled = NO;
    tabVC.tabBarItemTitleNormalColor = [UIColor colorWithHexString:@"b5b5b5"];
    tabVC.tabBarItemTitleSelectedColor= [UIColor colorWithHexString:@"FB7361"];
    tabVC.tabBarItemTitleOffset = UIOffsetMake(0, -2);

    tabVC.tabBarItemTitles = @[@"首页",
                               @"(JS)",
                               ];
    tabVC.tabBarItemImages = @[[UIImage imageNamed:@"tabbar_home"],
                               [UIImage imageNamed:@"tabbar_hot"],
                                ];
    tabVC.tabBarItemSelectedImages = @[[UIImage imageNamed:@"tabbar_home_select"],
                                       [UIImage imageNamed:@"tabbar_hot_select"],
                                        ];

    tabVC.contentViewControllers = @[webVC0,webVC1];
    tabVC.navigationControllerConstructor = ncc;
    
   
    [tabVC loadChildViewControllers];
//    [self updateRootViewController:tabVC animated:NO];
    return tabVC;

}

- (void)updateRootViewController:(UIViewController *)rootViewController animated:(BOOL)animated
{
    if (animated)
    {
        rootViewController.view.alpha = .0f;
        [UIView animateWithDuration:1.5f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             rootViewController.view.alpha = 1.0f;
                         }
                         completion:^(BOOL finished) {
                             
                             //
                         }];
    }
    
    self.window.rootViewController = rootViewController;

    
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if ([self.rootViewController isKindOfClass:TabBarController.class])
    {
        if ([viewController isKindOfClass: UINavigationController.class])
        {
            UINavigationController *navi = (UINavigationController *)viewController;
            
            if (navi.viewControllers.count > 0)
            {
                [navi popToRootViewControllerAnimated:YES];
            }
            else
            {
                
            }
        }
        
    }
    return YES;
}

#pragma mark - Member Methods
- (UIViewController *)rootViewController
{
    return self.window.rootViewController;
}

- (UIViewController *)viewControllerAtTabBarIndex:(NSUInteger)index ofClass:(Class)class
{
    if ([self.rootViewController isKindOfClass:UITabBarController.class])
    {
        TabBarController *tabBarController = (TabBarController *)self.rootViewController;
        UINavigationController *navi = tabBarController.viewControllers[index];
        if (navi.viewControllers[0] && [navi.viewControllers[0] isKindOfClass:class])
        {
            return (UIViewController *)(navi.viewControllers[0]);
        }
        else
        {
            for (UINavigationController *navi in tabBarController.viewControllers)
            {
                if (navi.viewControllers[0] && [navi.viewControllers[0] isKindOfClass:class])
                {
                    return (UIViewController *)(navi.viewControllers[0]);
                }
            }
        }
    }
    return nil;
}

// TabBar上 当前正在使用的NavigationController
- (UINavigationController *)wantedNavigationController
{
    if ([self.rootViewController isKindOfClass:TabBarController.class])
    {
        TabBarController *tabBarController = (TabBarController *)self.rootViewController;
        UINavigationController *navi = tabBarController.selectedViewController;
        if (navi && [navi isKindOfClass:UINavigationController.class])
        {
            return navi;
        }
    }
    return nil;
}

// TabBar上 当前正在使用的NavigationController的topViewController
- (UIViewController *)topViewController // topViewController
{
    UIViewController *topViewController = nil;
    if (self.rootViewController)
    {
        if ([self.rootViewController isKindOfClass:TabBarController.class])
        {
            TabBarController *tabBarController = (TabBarController *)self.rootViewController;
            topViewController = tabBarController.selectedViewController;
            
            if ([topViewController isKindOfClass:UINavigationController.class])
            {
                topViewController = ((UINavigationController *)topViewController).topViewController;
            }
        }
        else if ([self.rootViewController isKindOfClass:UINavigationController.class])
        {
            UINavigationController *navigationController = (UINavigationController *)self.rootViewController;
            topViewController = navigationController.topViewController;
        }
        else
        {
            topViewController = self.rootViewController;
        }
    }
    return topViewController;
    //    if (topViewController)
    //    {
    //        return [self checkTopViewController:topViewController];
    //    }
    //    else
    //    {
    //        return nil;
    //    }
}

- (UIViewController *)checkTopViewController:(UIViewController *)rootViewController {
    
    if (rootViewController.presentedViewController)
    {
        return [self checkTopViewController:rootViewController.presentedViewController];
    }
    else
    {
        if ([rootViewController isKindOfClass:UINavigationController.class])
        {
            return ((UINavigationController *)rootViewController).topViewController;
        }
        else
        {
            return rootViewController;
        }
    }
}
@end
