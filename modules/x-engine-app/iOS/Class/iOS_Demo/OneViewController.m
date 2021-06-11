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
#import "XENativeContext.h"
#import <Unity.h>
#import "TwoViewController.h"
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
    {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44);
    btn.backgroundColor = [UIColor systemPinkColor];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    }
    {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 44);
    btn.backgroundColor = [UIColor systemPinkColor];
    [btn setTitle:@"replace" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(replace) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    }
    
}
- (void)replace {
    [[Unity sharedInstance].getCurrentVC.navigationController popViewControllerAnimated:NO];

    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:[OneViewController new] animated:YES];

}


- (void)didClickBtn {
    
//    id<iDirectManager> director = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:[OneViewController new] animated:YES];
//    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:[OneViewController new] animated:YES];

    // 本地包
//    [director push:@"microapp" host:@"10.2.128.73:8082" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];

    // 远程10.2.128.71:8080
//    [director push:@"omp" host:@"10.2.128.73:8081" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
//    [director push:@"native" host:@"category" pathname:@"/Two"  fragment:@"" query:nil  params:@{@"hideNavbar":@TRUE}];
  

}
@end
