//
//  ThreeViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "ThreeViewController.h"

#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>


@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"flutter 3";
    UIButton *button = [[UIButton alloc]init];
       [button setTitle:@"加载Flutter模块" forState:UIControlStateNormal];
       button.backgroundColor=[UIColor redColor];
       button.frame = CGRectMake(50, 50, 200, 100);
       [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
       [button addTarget:self action:@selector(buttonPrint) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:button];
}

- (void)buttonPrint{
    FlutterViewController * flutterVC = [[FlutterViewController alloc]init];
    [flutterVC setInitialRoute:@"defaultRoute"];
    [self presentViewController:flutterVC animated:true completion:nil];
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
