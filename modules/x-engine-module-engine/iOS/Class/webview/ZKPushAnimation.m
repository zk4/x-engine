//
//  ZKPushAnimation.m
//  nav
//
//  Created by 吕冬剑 on 2020/9/18.
//  Copyright © 2020 edz. All rights reserved.
//

#import "ZKPushAnimation.h"
#import "Unity.h"
#import "UIViewController+ZKScreenCache.h"
#import "RecyleWebViewController.h"
#import "XEOneWebViewPool.h"

@interface ZKPushAnimation () <UIViewControllerAnimatedTransitioning>//UINavigationControllerDelegate

@property (nonatomic, assign) float animationTime;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@property (nonatomic, assign) BOOL isPush;

@property (nonatomic, weak) UIViewController *lastVc;

@property (nonatomic, assign) BOOL isTouchActioning;

@property (nonatomic, copy) NSString *fromUrl;
@property (nonatomic, copy) NSString *toUrl;

@end

@implementation ZKPushAnimation

+(ZKPushAnimation *)instance{
    static ZKPushAnimation *util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[ZKPushAnimation alloc] init];
    });
    return util;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animationTime = 0.3;
    }
    return self;
}

-(void)dealloc{
    
}

- (void)opennavtionGestreAction:(UINavigationController *)navController{
    
}

-(void)removeAnimationDelegate{
    [Unity sharedInstance].getCurrentVC.navigationController.delegate = nil;
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}
- (void)isOpenCustomAnimation:(BOOL)isOpen withFrom:(UIViewController *)fromVc withTo:(UIViewController *)toVc{
    if(
       [fromVc isKindOfClass:[RecyleWebViewController class]]
       &&
       [toVc isKindOfClass:[RecyleWebViewController class]]){
        
        if(isOpen && [XEOneWebViewPool sharedInstance].inSingle){
            UIGestureRecognizer *gesture = fromVc.navigationController.interactivePopGestureRecognizer;
            gesture.enabled = NO;
            UIView *gestureView = gesture.view;
            
            UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleControllerPop:)];
            edgePan.edges = UIRectEdgeLeft;
            [gestureView addGestureRecognizer:edgePan];
        } else {
            UIGestureRecognizer *gesture = fromVc.navigationController.interactivePopGestureRecognizer;
            gesture.enabled = YES;
        }
//        [Unity sharedInstance].getCurrentVC.navigationController.delegate = isOpen ? self : nil;
        [Unity sharedInstance].getCurrentVC.navigationController.delegate = isOpen ? self : nil;
    }
}
- (void)isOpenCustomAnimation:(BOOL)isOpen withNavigationController:(UINavigationController *)navController{
    
    
    if(isOpen && [XEOneWebViewPool sharedInstance].inSingle){
        UIGestureRecognizer *gesture = navController.interactivePopGestureRecognizer;
        gesture.enabled = NO;
        UIView *gestureView = gesture.view;
        
        UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleControllerPop:)];
        edgePan.edges = UIRectEdgeLeft;
        [gestureView addGestureRecognizer:edgePan];
    } else {
        UIGestureRecognizer *gesture = navController.interactivePopGestureRecognizer;
        gesture.enabled = YES;
    }
    [Unity sharedInstance].getCurrentVC.navigationController.delegate = isOpen ? self : nil;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush){
        self.isPush = YES;
    } else {
        self.isPush = NO;
    }
    self.lastVc = toVC;
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactivePopTransition;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.animationTime;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if(self.isPush){
        if([XEOneWebViewPool sharedInstance].inSingle){
            [self signlePushTo:transitionContext];
        } else {
            [self morePushTo:transitionContext];
        }
    }else{
        if([XEOneWebViewPool sharedInstance].inSingle){
            [self signlePopTo:transitionContext];
        } else {
            [self morePopTo:transitionContext];
        }
    }
}

-(void)signlePushTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    RecyleWebViewController *fromeVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RecyleWebViewController *viewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    if([viewController isKindOfClass:[RecyleWebViewController class]]){
        RecyleWebViewController *toVc = viewController;
        UIView *containerView = transitionContext.containerView;
        containerView.backgroundColor = [UIColor whiteColor];
        
        UIView *screenView = [fromeVc.view resizableSnapshotViewFromRect:fromeVc.view.bounds afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        screenView.backgroundColor = [UIColor whiteColor];
        UIImage *img = [self getImageFromView:fromeVc.view];
        [fromeVc setScreenImage:img];
        
        UIView *toView = toVc.view;
        [toVc setSignleWebView:[[XEOneWebViewPool sharedInstance] getWebView:toVc.fileUrl]];
        
        [toVc loadFileUrl:toVc.fileUrl];
        
        toView.layer.shadowColor = [UIColor blackColor].CGColor;
        toView.layer.shadowOffset = CGSizeMake(-3, 0);
        toView.layer.shadowOpacity = 0.2;
        
        screenView.frame = fromeVc.view.frame;//containerView.bounds;
        [containerView addSubview:screenView];
        [containerView addSubview:toView];
//        toView.frame = CGRectMake(toView.frame.size.width,
//                                  fromeVc.navigationController.navigationBar.bounds.size.height,//toView.frame.origin.y,
//                                  toView.frame.size.width,
//                                  containerView.bounds.size.height - fromeVc.navigationController.navigationBar.bounds.size.height);//toView.frame.size.height);
    toView.frame = CGRectMake(toView.frame.size.width,
                              toView.frame.origin.y,
                              toView.frame.size.width,
                              toView.frame.size.height);
        
        UIView *shawView = [[UIView alloc] init];
        shawView.frame = screenView.bounds;
        shawView.backgroundColor = [UIColor blackColor];
        shawView.alpha = 0;
        [screenView addSubview:shawView];
        
        [UIView animateWithDuration:self.animationTime
                         animations:^{
            
            screenView.frame = CGRectMake(fromeVc.view.frame.size.width * -0.5,
                                          screenView.frame.origin.y,
                                          screenView.frame.size.width,
                                          screenView.frame.size.height);
            toView.frame = CGRectMake(0,
                                      toView.frame.origin.y,
                                      toView.frame.size.width,
                                      toView.frame.size.height);
            shawView.alpha = 0.2;
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            [shawView removeFromSuperview];
            [screenView removeFromSuperview];
        }];
//    } else {
//
//    }
}

-(void)signlePopTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVc.view;
    UIView *fromeView = fromVc.view;
    
    if([toVc isKindOfClass:[RecyleWebViewController class]]){
        
        [containerView addSubview:toView];
        
        RecyleWebViewController *toVC = (RecyleWebViewController *)toVc;
        
        //获取toView的截屏
        UIImage *toScreenImg = [toVC getScreenImage];
        UIImageView *toViewScreenImageView = [[UIImageView alloc] initWithImage:toScreenImg];
        [containerView addSubview:toViewScreenImageView];
        toViewScreenImageView.frame = CGRectMake(toView.bounds.size.width * -0.5,
                                                 containerView.bounds.size.height - toViewScreenImageView.bounds.size.height,
                                                 containerView.bounds.size.width,
                                                 toViewScreenImageView.bounds.size.height);
        
        self.toUrl = toVC.fileUrl;
        UIView *fromScreenView = [fromVc.view resizableSnapshotViewFromRect:fromVc.view.bounds afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];;
        fromScreenView.layer.shadowColor = [UIColor blackColor].CGColor;
        fromScreenView.layer.shadowOffset = CGSizeMake(-6, 0);
        fromScreenView.layer.shadowOpacity = 0.2;
        fromScreenView.frame = fromVc.view.frame;

        [containerView addSubview:fromScreenView];
        
        UIView *shawView = [[UIView alloc] init];
        shawView.frame = fromScreenView.bounds;
        shawView.backgroundColor = [UIColor blackColor];
        shawView.alpha = 0.2;
        [toView addSubview:shawView];
        
        [toVC popUrl:toVC.fileUrl];
        
        [UIView animateWithDuration:self.animationTime
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
            shawView.alpha = 0;
            
            toViewScreenImageView.frame = CGRectMake(0,
                                                     containerView.bounds.size.height - toViewScreenImageView.bounds.size.height,
                                                     containerView.bounds.size.width,
                                                     toViewScreenImageView.bounds.size.height);
            
            fromScreenView.frame = CGRectMake(fromScreenView.frame.size.width,
                                              fromScreenView.frame.origin.y,
                                              fromScreenView.frame.size.width,
                                              fromScreenView.frame.size.height);
        } completion:^(BOOL finished) {
            
            if (!transitionContext.transitionWasCancelled) {
                
                [toVC setSignleWebView:[[XEOneWebViewPool sharedInstance] getWebView:toVC.fileUrl]];
                [fromScreenView removeFromSuperview];
                [shawView removeFromSuperview];
                [toViewScreenImageView removeFromSuperview];
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }else {
                if([fromVc isKindOfClass:[RecyleWebViewController class]]){
                    RecyleWebViewController *fromWeVC = (RecyleWebViewController *)fromVc;
                    [fromWeVC forwardUrl:fromWeVC.fileUrl];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [fromScreenView removeFromSuperview];
                    [shawView removeFromSuperview];
                    [toViewScreenImageView removeFromSuperview];
                    [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                });
                return;
            }
        }];
    } else {
//        toView.frame = CGRectMake(containerView.bounds.size.width * -0.5,
//                                  toView.frame.origin.y,
//                                  toView.bounds.size.width,
//                                  toView.bounds.size.height);
        toView.frame = CGRectMake(containerView.bounds.size.width * -0.5,
                                  0,
                                  toView.bounds.size.width,
                                  containerView.bounds.size.height);
        [containerView addSubview:toView];
        [containerView addSubview:fromeView];
        
        [UIView animateWithDuration:self.animationTime
                              delay:0
                            options:self.isTouchActioning ? UIViewAnimationOptionCurveLinear : UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            
            toView.frame = CGRectMake(0,
                                      toView.frame.origin.y,
                                      toView.bounds.size.width,
                                      toView.bounds.size.height);
            
            fromeView.frame = CGRectMake(fromeView.frame.size.width,
                                         fromeView.frame.origin.y,
                                         fromeView.frame.size.width,
                                         fromeView.frame.size.height);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            if (!transitionContext.transitionWasCancelled) {
                
                [Unity sharedInstance].getCurrentVC.navigationController.delegate = nil;
                UIGestureRecognizer *gesture = [Unity sharedInstance].getCurrentVC.navigationController.interactivePopGestureRecognizer;
                gesture.enabled = YES;
                
                if([fromVc isKindOfClass:[RecyleWebViewController class]]){
                    RecyleWebViewController *fromWeVC = (RecyleWebViewController *)fromVc;
//                    [fromWeVC popToRoot];
                    [fromWeVC pop];
                    [fromWeVC.webview removeFromSuperview];
                }
            }
        }];
    }
}

-(UIImage *)getImageFromView:(UIView *)view {
    
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer {
    
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        self.isTouchActioning = YES;
        [self.lastVc.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        if (progress > 0.3) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
        self.isTouchActioning = NO;
    }
}



-(void)morePushTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    RecyleWebViewController *fromeVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RecyleWebViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    UIView *screenView = [fromeVc.view resizableSnapshotViewFromRect:fromeVc.view.bounds afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    UIView *toView = toVc.view;
//    [toVc setSignleWebView:nil];
    
    toView.layer.shadowColor = [UIColor blackColor].CGColor;
    toView.layer.shadowOffset = CGSizeMake(-3, 0);
    toView.layer.shadowOpacity = 0.2;
    
    screenView.frame = fromeVc.view.frame;
    [containerView addSubview:screenView];
    [containerView addSubview:toView];
    
    toView.frame = CGRectMake(toView.frame.size.width,
                              toView.frame.origin.y,
                              toView.frame.size.width,
                              toView.frame.size.height);
    
    UIView *shawView = [[UIView alloc] init];
    shawView.frame = screenView.bounds;
    shawView.backgroundColor = [UIColor blackColor];
    shawView.alpha = 0;
    [screenView addSubview:shawView];
    
    [UIView animateWithDuration:self.animationTime
                     animations:^{
        screenView.frame = CGRectMake(fromeVc.view.frame.size.width * -0.5,
                                      screenView.frame.origin.y,
                                      screenView.frame.size.width,
                                      screenView.frame.size.height);
        toView.frame = CGRectMake(0,
                                  toView.frame.origin.y,
                                  toView.frame.size.width,
                                  toView.frame.size.height);
        shawView.alpha = 0.2;
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        [shawView removeFromSuperview];
        [screenView removeFromSuperview];
    }];
}

-(void)morePopTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = transitionContext.containerView;
    RecyleWebViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *vc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = vc.view;
    UIView *fromeView = fromVC.view;
    
    toView.frame = CGRectMake(containerView.bounds.size.width * -0.5,
                              toView.frame.origin.y,
                              toView.bounds.size.width,
                              toView.bounds.size.height);
    [containerView addSubview:toView];
    [containerView addSubview:fromeView];
    
    [UIView animateWithDuration:self.animationTime
                          delay:0
                        options:self.isTouchActioning ? UIViewAnimationOptionCurveLinear : UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        
        toView.frame = CGRectMake(0,
                                  toView.frame.origin.y,
                                  toView.bounds.size.width,
                                  toView.bounds.size.height);
        
        fromeView.frame = CGRectMake(fromeView.frame.size.width,
                                     fromeView.frame.origin.y,
                                     fromeView.frame.size.width,
                                     fromeView.frame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        [Unity sharedInstance].getCurrentVC.navigationController.delegate = nil;
    }];
}

@end
