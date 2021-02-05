//
//  ZKTabBarViewController.m
//  xxxx
//
//  Created by 李宫 on 2021/2/1.
//  Copyright © 2021 zk. All rights reserved.
//

#import "ZKTabBarViewController.h"
#import "firstViewController.h"
#import "ZKTabBar.h"
@interface ZKTabBarViewController ()

@end

@implementation ZKTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    firstViewController *vc = [[firstViewController alloc] init];
    [self addChildController:vc title:@"回到顶部" imageName:@"tab" selectedImageName:@"tab" navVc:[UINavigationController class]];
    UIViewController *communityVC = [[UIViewController alloc] init];
    [self addChildController:communityVC title:@"社区" imageName:@"tab" selectedImageName:@"tab" navVc:[UINavigationController class]];
    UIViewController *masseageVC = [[UIViewController alloc] init];
    [self addChildController:masseageVC title:@"消息" imageName:@"tab" selectedImageName:@"tab" navVc:[UINavigationController class]];
    UIViewController *mineVC = [[UIViewController alloc] init];
    [self addChildController:mineVC title:@"我的" imageName:@"tab" selectedImageName:@"tab" navVc:[UINavigationController class]];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    //  设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    // 设置自定义的tabbar
    [self setCustomtabbar];
}

- (void)setCustomtabbar{

    ZKTabBar *tabbar = [[ZKTabBar alloc]init];
    
    [self setValue:tabbar forKeyPath:@"tabBar"];

    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)centerBtnClick:(UIButton *)btn{
    NSLog(@"点击了中间");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击了中间按钮" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UINavigationController* nav = [[navVc alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}


- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
