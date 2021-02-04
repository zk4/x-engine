//
//  firstViewController.m
//  xxxx
//
//  Created by 李宫 on 2021/2/2.
//  Copyright © 2021 zk. All rights reserved.
//

#import "firstViewController.h"

@interface firstViewController ()

@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController * vc= [[XEOneWebViewControllerManage sharedInstance]getWebViewControllerWithId:@"com.times.microapp.AppcMin"];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}



@end
