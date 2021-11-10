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
    
    // tab
//    [XENP(iDirectManager) addToTab:self uri:@"rn://localhost:8081/index.bundle?platform=ios" moduleName:@"App" params:@{@"hideNavbar":@TRUE} frame:[UIScreen mainScreen].bounds];
    
    // push
//    [XENP(iDirectManager) push:@"rn://localhost:8081/index.bundle?platform=ios" moduleName:@"App" params:@{@"hideNavbar":@TRUE} frame:[UIScreen mainScreen].bounds];
}

- (void)setupUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100, [UIScreen mainScreen].bounds.size.height / 2 - 200, 200, 200);
    [btn setTitle:@"click me" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoRn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)gotoRn {
    [XENP(iDirectManager) push:@"rn://localhost:8081/index.bundle?platform=ios" moduleName:@"App" params:@{@"hideNavbar":@TRUE} frame:[UIScreen mainScreen].bounds];
}
@end
