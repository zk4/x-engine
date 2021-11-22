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
    CGRect frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-tabbarHeight);
    [XENP(iDirectManager) addToTab:self uri:@"lrn://rnapps/index.bundle" params:@{@"hideNavbar":@TRUE, @"__RN__":@{@"moduleName":@"App"}} frame:frame];
//    [XENP(iDirectManager) addToTab:self uri:@"orn://localhost:8081/index.bundle?platform=ios" params:@{@"hideNavbar":@TRUE, @"__RN__":@{@"moduleName":@"App"}} frame:frame];
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"rnapps/index.bundle" withExtension:nil];
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:url moduleName:@"taroDemo" initialProperties:nil launchOptions:nil];
//    rootView.frame = self.view.frame;
//    [self.view addSubview: rootView];
}
@end
