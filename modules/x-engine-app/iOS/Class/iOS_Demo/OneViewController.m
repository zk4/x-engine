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
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44);
    btn.backgroundColor = [UIColor systemPinkColor];
    [btn setTitle:@"jump" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didClickBtn {
    id<iDirectManager> director = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
    
    // 本地包
    [director push:@"microapp" host:@"10.2.128.73:8082" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];

    // 远程
//    [director push:@"omp" host:@"10.2.128.61:8080" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
//    [director push:@"native" host:@"category" pathname:@"/Two"  fragment:@"" query:nil  params:@{@"hideNavbar":@TRUE}];
  

}
@end
