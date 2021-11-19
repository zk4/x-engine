//
//  ThreeViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "ThreeViewController.h"
#import <iDirectManager.h>
#import <XENativeContext.h>
#import "iDevice.h"
@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id<iDevice> device = XENP(iDevice);
    float tabbarHeight= [device getTabbarHeight];
    CGRect frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-tabbarHeight);
    // 本地地址加载rn
    [XENP(iDirectManager) addToTab:self uri:@"omp://10.2.148.80:8080" params:@{@"hideNavbar":@TRUE} frame:frame];
}
@end
