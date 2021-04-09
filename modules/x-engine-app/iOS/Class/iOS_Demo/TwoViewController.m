//
//  TwoViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "TwoViewController.h"
#import "XEngineWebView.h"
#import "WebViewFactory.h"
#import "NativeContext.h"
#import "iDirectManager.h"
#import "RecyleWebViewController.h"
#import "MicroAppLoader.h"
@interface TwoViewController ()
@property (nonatomic, strong) XEngineWebView * _Nullable webview;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块2";

    ///TODO: 统一一个类处理 URL 地址问题
    NSString* protocol= @"file:";
    NSString* host = @"com.gm.microapp.mine";
    NSString* fragment = @"/";
    
//    NSString * finalUrl = [NSString stringWithFormat:@"%@//%@",protocol,host];
//    if(pathname && ![pathname isEqualToString:@"/"]){
//        finalUrl =[NSString stringWithFormat:@"%@#%@",finalUrl,pathname];
//    }
    NSString *localhost = [[MicroAppLoader sharedInstance] getMicroAppHost:host withVersion:0];
    NSString * finalUrl = [NSString stringWithFormat:@"%@//%@",protocol,localhost];

    RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl host:host fragment:fragment newWebView:TRUE  withHiddenNavBar:TRUE];

    /// TODO:  背景没有生效
    vc.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];

    vc.view.frame = self.view.frame;
    

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
