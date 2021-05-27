//
//  PresentCustomAnimation.m
//  HelloUniMPDemo
//
//  Created by tk-ios03 on 2020/4/16.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "PresentCustomAnimation.h"

@implementation PresentCustomAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromContro = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toContro = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect toControFrame = [transitionContext finalFrameForViewController:toContro];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toContro.view];

    toContro.view.frame = CGRectOffset(toControFrame, [[UIScreen mainScreen] bounds].size.width, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromContro.view.alpha = 0.5;
        toContro.view.frame = toControFrame;
        fromContro.view.frame = CGRectOffset(fromContro.view.frame, -50, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
