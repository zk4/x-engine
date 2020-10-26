//
//  ZYDL_TabBarController.m
//  KSSM
//
//  Created by Chenwuzheng on 2019/3/28.
//  Copyright © 2019 xr. All rights reserved.
//

#import "ZYDL_TabBarController.h"
#import "Prefix.h"
#import "EntryViewController.h"
#import "ZKMicroAppViewController.h"
#import "ZKModuleViewController.h"
@interface ZYDL_TabBarController ()

@end

@implementation ZYDL_TabBarController
+ (void)initialize {
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = kRGBColor(153, 153, 153);
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = kRGBColor(0, 0, 0);
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    [[UITabBarItem appearance] setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc:[[ZKMicroAppViewController alloc] init] title:@"微应用" image:@"home_nor" selectedImage:@"home_sel"];
    [self setupChildVc:[[ZKModuleViewController alloc] init] title:@"模块" image:@"serve_nor" selectedImage:@"serve_sel"];
    [self setupChildVc:[[EntryViewController alloc] init] title:@"日志" image:@"shop_nor" selectedImage:@"shop_sel"];
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.tabBarItem.selectedImage =  [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
