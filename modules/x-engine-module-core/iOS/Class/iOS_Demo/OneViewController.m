//
//  OneViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "OneViewController.h"
#import "JumpViewController.h"
#import "NativeContext.h"
#import "iDirectManager.h"
@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块1";
    [self setupView];
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
//    [self.navigationController pushViewController:[[JumpViewController alloc ] init] animated:YES];
    id<iDirectManager> director = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
//    [img open:@"microapp" :@"com.gm.microapp.mine" :@"/" :@{} :0 :TRUE];
//    [img open:@"microapp" :@"com.gm.microapp.mine" :@"/" :@{} :0 :TRUE];
//    [img open:@"h5" :@"https://www.baidu.com" :@"/" :@{} :0 :TRUE];
//    [img open:@"omp" :@"http://192.168.1.15:8080" :@"/" :@{} :0 :TRUE];
    [director push:@"h5" host:@"http://10.2.128.80:8080" path:@"" query:nil hideNavbar:TRUE];

}

@end
