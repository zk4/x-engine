//
//  TwoViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "TwoViewController.h"

#import "RecyleWebViewController.h"
#import "MicroAppLoader.h"
#import <GlobalState.h>

@interface TwoViewController ()
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块2";

    ///TODO: 统一一个类处理 URL 地址问题
    NSString* protocol= @"file:";
    NSString* microappid = @"com.gm.microapp.mine";
    NSString* fragment = @"/";
    

    NSString *localhost = [[MicroAppLoader sharedInstance] getMicroAppHost:microappid withVersion:0];
    NSString * finalUrl = [NSString stringWithFormat:@"%@//%@",protocol,localhost];

    RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl host:localhost pathname:@"" fragment:fragment  withHiddenNavBar:TRUE onTab:TRUE];

    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = self.view.frame;
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"............");
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
