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
//    [XENP(iDirectManager) addToTab:self uri:@"microapp://com.zkty.microapp.min11e" params:@{@"hideNavbar":@TRUE,@"nativeParams":@{@"__fallback__":@"microapp://com.zkty.microapp.home"}}];
//    [XENP(iDirectManager) addFallbackRouter:@"microapp://microapp.demo" fallback:@"http://www.baidu.com"];
//    [XENP(iDirectManager) addToTab:self uri:@"microapp://microapp.demo" params:@{@"hideNavbar":@TRUE}];
  
    id<iDevice> device = XENP(iDevice);
    float tabbarHeight= [device getTabbarHeight];
    NSString* navHeight =[device getNavigationHeight];
    float fCost = [navHeight floatValue];

    CGRect frame =   CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-tabbarHeight);

    [XENP(iDirectManager) addToTab:self uri:@"http://10.2.128.255:8080" params:@{@"hideNavbar":@TRUE} frame:frame];

//    [XENP(iDirectManager) addToTab:self uri:@"microapp://microapp.demo" params:@{@"hideNavbar":@TRUE} frame:frame];

}
@end
