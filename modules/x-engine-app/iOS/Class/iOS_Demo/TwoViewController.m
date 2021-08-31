//
//  TwoViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "TwoViewController.h"
#import <iDirectManager.h>
#import <XENativeContext.h>

@interface TwoViewController ()
@end

@implementation TwoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块2";
    [XENP(iDirectManager) addToTab:self uri:@"omp://10.2.128.64:8080" params:@{@"hideNavbar": @TRUE} frame:[UIScreen mainScreen].bounds];
}
@end
