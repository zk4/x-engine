//
//  UIViewController+Push_Present.m
//  Family
//
//  Created by jia on 15/9/17.
//  Copyright (c) 2015年 jia. All rights reserved.
//

#import "UIViewController+Push_Present.h"
//#import "UIViewController+Customized.h"
//#import "UINavigationController+Customized.h"
//#import "NavigationController.h"

@implementation UIViewController (Push_Present)


//- (void)popToViewControllerLevel:(NSNumber *)level
//{
//    UINavigationController *navigationController = nil;
//    if ([self isKindOfClass:UINavigationController.class]) {
//        navigationController = (UINavigationController *)self;
//    } else if (self.navigationController) {
//        navigationController = self.navigationController;
//    } else {
//        // error
//        return;
//    }
//
//    if (navigationController.viewControllers.count > labs(level.integerValue)) {
//        NSInteger index = (level.integerValue >= 0) ? level.integerValue : (navigationController.viewControllers.count + level.integerValue - 1);
//        if (index >= 0 && navigationController.viewControllers.count > index) {
//            UIViewController *vc = navigationController.viewControllers[index];
//            if (vc) {
//                [navigationController popToViewController:vc animated:YES];
//                return;
//            }
//        }
//    }
//
//    // 回跳一级
//    [navigationController popViewControllerAnimated:YES];
//}

- (BOOL)isExistedViewController:(Class)targetClass
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:targetClass]) {
            return YES;
        }
    }
    return NO;
}

@end
