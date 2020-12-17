//
//  UIViewController+Hook.m
//  HelloUniMPDemo
//
//  Created by tk-ios03 on 2020/4/16.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "UIViewController+Hook.h"
#import <objc/message.h>
#import "PresentCustomAnimation.h"
#import "DismissCustomAnimation.h"
#import <x-engine-module-engine/Unity.h>
#import "RecyleWebViewController.h"
@implementation UIViewController (Hook)

+(void)load{
    Method presentMethod = class_getInstanceMethod([UIViewController class], @selector(presentViewController:animated:completion:));
    Method pushMethod = class_getInstanceMethod([UIViewController class], @selector(hook_presentViewController:animated:completion:));
    method_exchangeImplementations(presentMethod, pushMethod);
    
    Method dismissMethod = class_getInstanceMethod([UIViewController class], @selector(dismissViewControllerAnimated:completion:));
    Method hook_dismissMethod = class_getInstanceMethod([UIViewController class], @selector(hook_dismissViewControllerAnimated:completion:));
    method_exchangeImplementations(dismissMethod, hook_dismissMethod);
}

-(void)hook_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self hook_dismissViewControllerAnimated:flag completion:completion];
    if ([self isKindOfClass:NSClassFromString(@"DCUniMPViewController")] &&
        ![self.presentedViewController isKindOfClass:[UIAlertController class]]){
        self.transitioningDelegate = nil;
        [[Unity sharedInstance].getCurrentVC.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return PresentCustomAnimation.new;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return DismissCustomAnimation.new;
}

-(void)hook_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    if ([viewControllerToPresent isKindOfClass:NSClassFromString(@"DCUniMPViewController")]) {
        viewControllerToPresent.transitioningDelegate = self;
        
}else{
        
    }
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:viewControllerToPresent animated:YES];
    [Unity sharedInstance].getCurrentVC.navigationController.delegate = self;
    
//    [self hook_presentViewController:viewControllerToPresent animated:flag completion:completion];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden: [self hiddenBarVc: viewController] animated: animated];
}

- (BOOL)hiddenBarVc:(UIViewController *)viewController {
    BOOL needHideNaivgaionBar = YES;
    if ([viewController isKindOfClass:NSClassFromString(@"RecyleWebViewController")]) {
        needHideNaivgaionBar = NO;
    }
    
    return needHideNaivgaionBar;
}

@end
