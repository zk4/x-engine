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
    [self setupUI];
}

- (void)setupUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100, [UIScreen mainScreen].bounds.size.height / 2 - 200, 200, 80);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 15.0;
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn setTitle:@"Push React Native" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoRn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)gotoRn {
//    [XENP(iDirectManager) push:@"orn://localhost:8081/index.bundle?platform=ios"  params:@{@"hideNavbar":@TRUE,@"__RN__":@{@"moduleName":@"App"}} frame:[UIScreen mainScreen].bounds];
    
//    [XENP(iDirectManager) push:@"orn://localhost:8081/index.bundle?platform=ios"  params:@{@"hideNavbar":@TRUE,@"__RN__":@{@"moduleName":@"taroDemo"}} frame:[UIScreen mainScreen].bounds];
    
    NSString *url = @"omp://10.2.148.80:10086/#/pages/index/index";
    [XENP(iDirectManager) push:url params:@{@"hideNavbar":@TRUE} frame:[UIScreen mainScreen].bounds];
}
@end
