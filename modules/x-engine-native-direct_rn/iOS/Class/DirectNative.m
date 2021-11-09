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
        UIViewController *one = [UIViewController new];
        one.view.backgroundColor = [UIColor orangeColor];
        [nav pushViewController:one animated:YES];
    });
}

RCT_EXPORT_METHOD(backNative) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav popToRootViewControllerAnimated:YES];
    });
}
@end
