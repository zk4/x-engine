//
//  JumpViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "JumpViewController.h"
#import "iDirectManager.h"
#import "XENativeContext.h"
@interface JumpViewController ()

@end

@implementation JumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"JustViewController";
    [self setupView];
}
- (void)setupView {
    {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44);
    btn.backgroundColor = [UIColor systemPinkColor];
    [btn addTarget:self action:@selector(btnclik) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"push" forState:UIControlStateNormal];
         [self.view addSubview:btn];
    }
    {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 44);
    btn.backgroundColor = [UIColor systemPinkColor];
    [btn setTitle:@"back" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn];
    }
    
}
 

-(void)btnclik {
    [XENP(iDirectManager) push:@"omp://127.0.0.1:8080/#/testone" params:@{@"hideNavbar":@TRUE, @"onTab":@TRUE}];

}
-(void)back {
    [XENP(iDirectManager) back:@"native" host:nil fragment:@"-1"];
}
@end
