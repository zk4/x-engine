//
//  ZKPushAnimation.h
//  nav
//
//  Created by 吕冬剑 on 2020/9/18.
//  Copyright © 2020 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKPushAnimation : NSObject

+ (ZKPushAnimation *)instance;

- (void)isOpenCustomAnimation:(BOOL)isOpen withFrom:(UIViewController *)fromVc withTo:(UIViewController *)toVc;
- (void)isOpenCustomAnimation:(BOOL)isOpen withNavigationController:(UINavigationController *)navController;

//- (void)navtionGestreAction:(UINavigationController *)navController;
//- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;

@end

NS_ASSUME_NONNULL_END
