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
//    [self.navigationController pushViewController:[[JumpViewController alloc ] init] animated:YES];
    id<iDirectManager> director = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
    
    /*
    1 将com.gm.microapp.mine.0的microapp.json文件拖出项目后 可以测试无法打开应用的提示
    2 将com.gm.microapp.mine.0的microapp.json文件中的com.zkty.jsi.direct模块去掉，可以测试没有该模块的提示
    3 将com.gm.microapp.mine.0的microapp.json文件中的network的www.fastmock.site域名去掉后，在模拟器上点网络请求，会报不包含该域名,添加上可以请求到数据 为userinfo:null
    */
    [director push:@"microapp" host:@"com.gm.microapp.mine" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
    
//    [director push:@"omp" host:@"10.2.128.89:8080" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
    
//    [director push:@"http" host:@"www.baidu.com" pathname:@"/" query:nil params:@{@"hideNavbar":@TRUE}];
//    [director push:@"omp" host:@"10.2.128.89:8080" pathname:@"/" query:nil
//      [director push:@"omp" host:@"192.168.1.15:8082" pathname:@"" fragment:@"/" query:nil  params:@{@"hideNavbar":@YES}];
//    [director push:@"omp" host:@"10.2.128.89:8080" pathname:@"" fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
//    [director push:@"omp" host:@"10.2.128.73:8080" pathname:@"" fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
    
//    [director push:@"omp" host:@"192.168.1.15:9111" pathname:@"/" query:nil params:@{@"hideNavbar":@NO}];
    
//    [director push:@"omp" host:@"10.2.128.80:8080" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
    

}
@end
