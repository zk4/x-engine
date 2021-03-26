//
//  TwoViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "TwoViewController.h"
#import "XEngineWebView.h"
#import "XEOneWebViewPool.h"

@interface TwoViewController ()
@property (nonatomic, strong) XEngineWebView * _Nullable webview;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块2";
    // TODO
    // temp webviewpool 需要重新设计 api
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    XEngineWebView* webview = [[XEngineWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    
    webview.configuration.preferences.javaScriptEnabled = YES;
    webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    [webview.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    [webview.configuration setValue:@YES forKey:@"allowUniversalAccessFromFileURLs"];
    self.webview=webview;
    [self.webview loadUrl:@"https://www.baidu.com"];
    self.webview.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.webview];

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
