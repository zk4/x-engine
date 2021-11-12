//
//  TwoViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "TwoViewController.h"
#import <iDirectManager.h>
#import <XENativeContext.h>
#import "iDevice.h"
@interface TwoViewController ()
@end

@implementation TwoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块2";
    id<iDevice> device = XENP(iDevice);
    float tabbarHeight= [device getTabbarHeight];
    CGRect frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-tabbarHeight);
    [XENP(iDirectManager) addToTab:self uri:@"microapp://com.test.microapp.home" params:@{@"hideNavbar":@TRUE} frame:frame];
    
//    // tab
//    [XENP(iDirectManager) addToTab:self uri:@"rn://localhost:8081/index.bundle?platform=ios" moduleName:@"App" params:@{@"hideNavbar":@TRUE} frame:[UIScreen mainScreen].bounds];
}
@end
