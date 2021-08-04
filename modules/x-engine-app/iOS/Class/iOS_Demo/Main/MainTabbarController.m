//
//  MainTabbarController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "MainTabbarController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "MainNavigationController.h"
#import <x-engine-native-tabbar/iTabbar.h>
#import <x-engine-native-core/XENativeContext.h>


@interface MainTabbarController ()

@end

@implementation MainTabbarController
+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:178/255.0 green:181/255.0 blue:191/255.0 alpha:1];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:99/255.0 green:194/255.0 blue:202/255.0 alpha:1];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [XENP(iTabbar) registerDelegate:self];
        
    [self setupChildVc:[[OneViewController alloc] init] title:@"模块1" image:@"one-nor" selectedImage:@"one-sel"];
    
    [self setupChildVc:[[TwoViewController alloc] init] title:@"模块2" image:@"two-nor" selectedImage:@"two-sel"];
    
    [self setupChildVc:[[ThreeViewController alloc] init] title:@"模块3" image:@"three-nor" selectedImage:@"three-sel"];
    
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
- (UIViewController*)getCurrentTabItemVC{
    UIViewController* ret= [self.viewControllers objectAtIndex:self.selectedIndex ];
    NSArray* children = ret.childViewControllers;
    return children[0];
}
@end
