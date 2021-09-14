//
//  OneViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "OneViewController.h"
#import "iDirectManager.h"
#import "XENativeContext.h"
#import "iDevice.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id<iDevice> device = XENP(iDevice);
    float tabbarHeight= [device getTabbarHeight];
    NSString* navHeight =[device getNavigationHeight];
    float fCost = [navHeight floatValue];

    CGRect frame =   CGRectMake(0, fCost, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-tabbarHeight);

    [XENP(iDirectManager) addToTab:self uri:@"microapp://todo" params:@{@"hideNavbar":@TRUE} frame:frame];

}
@end
