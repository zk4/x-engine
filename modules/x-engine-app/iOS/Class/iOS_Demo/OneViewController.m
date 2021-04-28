//
//  OneViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "OneViewController.h"
#import "JumpViewController.h"
#import "iDirectManager.h"
#import "NativeContext.h"
@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块1";
    [self setupView];
//    [self didClickBtn];
}

- (void)setupView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44);
    btn.backgroundColor = [UIColor systemPinkColor];
    [btn setTitle:@"jump" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didClickBtn {
    id<iDirectManager> director = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
    
    // 本地com.gm.microapp.mine包
    [director push:@"microapp" host:@"com.gm.microapp.mine" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];

//     cwz 远程
    [director push:@"omp" host:@"10.2.128.80:8080" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
//    [director push:@"omp" host:@"10.2.128.89:8080" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
//    [director push:@"omp" host:@"192.168.3.12:8080" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
    
    // zk4 远程 请替换host
//    [director push:@"omp" host:@"10.2.128.89:8080" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
}
@end
