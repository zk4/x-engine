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
#import "NativeContext.h"
#import "iDirectManager.h"
@interface TwoViewController ()
@property (nonatomic, strong) XEngineWebView * _Nullable webview;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块2";
    // TODO
    // temp webviewpool 需要重新设计 api
    id<iDirectManager> director = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];

    [director push:@"omp" host:@"10.2.128.80:8082" pathname:@"/" query:nil params:@{@"hideNavbar":@"hello"}];


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
