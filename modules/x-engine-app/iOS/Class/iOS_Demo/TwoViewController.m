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
    
//    NSString * finalUrl = [NSString stringWithFormat:@"%@//%@",protocol,host];
//    if(pathname && ![pathname isEqualToString:@"/"]){
//        finalUrl =[NSString stringWithFormat:@"%@#%@",finalUrl,pathname];
//    }
    NSString *localhost = [[MicroAppLoader sharedInstance] getMicroAppHost:microappid withVersion:0];
    NSString * finalUrl = [NSString stringWithFormat:@"%@//%@",protocol,localhost];

    RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl host:localhost pathname:@"" fragment:@"" withHiddenNavBar:YES onTab:YES];
    

    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = self.view.frame;
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"............");
}
@end
