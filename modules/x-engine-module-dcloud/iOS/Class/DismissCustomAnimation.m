//
//  DismissCustomAnimation.m
//  HelloUniMPDemo
//
//  Created by tk-ios03 on 2020/4/16.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "DismissCustomAnimation.h"

@implementation DismissCustomAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromContro = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toContro = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromControFrame = [transitionContext initialFrameForViewController:fromContro];
    UIView *containerView = [transitionContext containerView];
    if (fromContro.modalPresentationStyle == UIModalPresentationFullScreen) {
        [containerView addSubview:toContro.view];
    }
    [containerView sendSubviewToBack:toContro.view];
    if (fromContro.modalPresentationStyle == UIModalPresentationCustom) {
        [toContro beginAppearanceTransition:YES animated:YES];
    }
 
    CGRect finalFrame = CGRectOffset(fromControFrame, [[UIScreen mainScreen] bounds].size.width, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromContro.view.frame = finalFrame;
        toContro.view.alpha = 1.0;
        toContro.view.frame = CGRectOffset(toContro.view.frame, 50, 0);
    } completion:^(BOOL finished) {
        if (fromContro.modalPresentationStyle == UIModalPresentationCustom) {
            [toContro endAppearanceTransition];
        }
        BOOL complate = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:(!complate)];
    }];

}

@end
