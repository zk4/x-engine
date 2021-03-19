//
//  firstViewController.m
//  xxxx
//
//  Created by 李宫 on 2021/2/2.
//  Copyright © 2021 zk. All rights reserved.
//

#import "firstViewController.h"
#import "twoViewController.h"
#import "threeViewController.h"
#import "fourViewController.h"
#import "fiveViewController.h"
@interface firstViewController ()

@end

@implementation firstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self createBtn];
}

- (void)createBtn{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"不能访问baidu" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor systemBlueColor];
    btn1.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 50);
    [btn1 addTarget:self action:@selector(didClickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"strict is false" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor grayColor];
    btn2.frame = CGRectMake(0, CGRectGetMaxY(btn1.frame), [UIScreen mainScreen].bounds.size.width, 50);
    [btn2 addTarget:self action:@selector(didClickBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"route没有权限"  forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor systemPinkColor];
    btn3.frame = CGRectMake(0, CGRectGetMaxY(btn2.frame), [UIScreen mainScreen].bounds.size.width, 50);
    [btn3 addTarget:self action:@selector(didClickBtn3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"不显示导航条(没有返回的机会)" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor systemTealColor];
    btn4.frame = CGRectMake(0, CGRectGetMaxY(btn3.frame), [UIScreen mainScreen].bounds.size.width, 50);
    [btn4 addTarget:self action:@selector(didClickBtn4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)didClickBtn1 {
    [self.navigationController pushViewController:[[twoViewController alloc] init] animated:YES];
}

- (void)didClickBtn2 {
    [self.navigationController pushViewController:[[threeViewController alloc] init] animated:YES];
}

- (void)didClickBtn3 {
    [self.navigationController pushViewController:[[fourViewController alloc] init] animated:YES];
}

- (void)didClickBtn4 {
    [self.navigationController pushViewController:[[fiveViewController alloc] init] animated:YES];
}

@end
