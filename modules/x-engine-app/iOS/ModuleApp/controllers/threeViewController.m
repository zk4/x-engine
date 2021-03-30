//
//  threeViewController.m
//  xxxx
//
//  Created by cwz on 2021/3/18.
//  Copyright © 2021 zk. All rights reserved.
//

#import "threeViewController.h"
#import "XEOneWebViewControllerManage.h"

@interface threeViewController ()

@end

@implementation threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController * vc= [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithId:@"com.times.microapp.App2Min"];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}
@end
