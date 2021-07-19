//
//  JumpViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "JumpViewController.h"

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
    [btn setTitle:@"push" forState:UIControlStateNormal];
         [self.view addSubview:btn];
    }
    {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 44);
    btn.backgroundColor = [UIColor systemPinkColor];
    [btn setTitle:@"replace" forState:UIControlStateNormal];
  
    [self.view addSubview:btn];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
