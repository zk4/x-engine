//
//  FourViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/11/19.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "FourViewController.h"
#import "iDirectManager.h"
#import "XENativeContext.h"
#import <iDirectManager.h>
#import "iDevice.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id<iDevice> device = XENP(iDevice);
    float tabbarHeight= [device getTabbarHeight];
    CGRect frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-tabbarHeight);
    [XENP(iDirectManager) addToTab:self uri:@"microapp://com.test.microapp.home" params:@{@"hideNavbar":@TRUE} frame:frame];
}
@end
