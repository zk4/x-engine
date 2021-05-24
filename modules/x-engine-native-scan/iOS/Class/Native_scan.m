//
//  Native_scan.m
//  scan
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_scan.h"
#import "XENativeContext.h"
#import "ScanViewController.h"

@interface Native_scan()
{ }
@end

@implementation Native_scan
NATIVE_MODULE(Native_scan)

 - (NSString*) moduleId{
    return @"com.zkty.native.scan";
}

- (int) order{
    return 0;
}

- (void)afterAllXENativeModuleInited{}


- (void)openScanView:(void (^)(NSString * res))completionHandler {
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    [[self getCurrentVC].navigationController pushViewController:scanVC animated:YES];
    scanVC.callBack = ^(NSString * _Nullable result) {
        completionHandler(result);
    };
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UINavigationController *nav = (UINavigationController *)rootVC;
        currentVC = [self getCurrentVCFrom:[nav topViewController]];
        //        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}
@end
