//
//  DirectNative.m
//  direct_rn
//
//  Created by cwz on 2021/11/9.
//  Copyright © 2021 zk. All rights reserved.
//

#import "DirectNative.h"

@implementation DirectNative
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(pushNative) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav setHidesBottomBarWhenPushed:YES];
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor orangeColor];
        [nav pushViewController:vc animated:YES];
//        if ([nav isKindOfClass:[UINavigationController class]]) {
//            [nav pushViewController:vc animated:YES];
//        } else {
//            UINavigationController *nav = [[UINavigationController alloc] init];
//            [nav pushViewController:vc animated:YES];
//        }
    });
}

RCT_EXPORT_METHOD(backNative) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav popToRootViewControllerAnimated:YES];
    });
}
@end
