//
//  xengine__module_scan.m
//  scan
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_scan.h"
#import <x-engine-module-engine/XEngineContext.h>
#import <x-engine-module-engine/micros.h>
#import <x-engine-module-engine/Unity.h>
#import <x-engine-module-engine/RecyleWebViewController.h>
#import <x-engine-module-engine/XEngineWebView.h>
#import "ZKScanViewController.h"

@interface __xengine__module_scan()
@end

@implementation __xengine__module_scan
 
- (void)_openScanView:(ScanOpenDto *)dto complete:(void (^)(BOOL))completionHandler{
    ZKScanViewController *vc = [[ZKScanViewController alloc] init];
    vc.block = ^(NSString *data) {
//        UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
//        RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
//        [webVC runJsFunction:dto.__event__ arguments:data];
        [[RecyleWebViewController webview] callHandler:dto.__event__  arguments:data completionHandler:nil];
    };
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
    completionHandler(YES);
}



@end
 
