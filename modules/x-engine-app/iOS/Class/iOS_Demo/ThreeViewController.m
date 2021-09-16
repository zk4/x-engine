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
    NSString* navHeight =[device getNavigationHeight];
    float fCost = [navHeight floatValue];

    CGRect frame =   CGRectMake(0, fCost, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-tabbarHeight);
//    [XENP(iDirectManager) push:@"omp://10.2.128.33:8080/#/" params:@{@"hideNavbar":@TRUE}];
    [XENP(iDirectManager) addToTab:self uri:@"omp://10.2.128.78:8081/#/" params:@{@"hideNavbar":@TRUE} frame:frame];
}
@end
