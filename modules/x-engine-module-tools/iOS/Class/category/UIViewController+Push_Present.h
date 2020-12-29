//
//  UIViewController+Push_Present.h
//  Family
//
//  Created by jia on 15/9/17.
//  Copyright (c) 2015年 jia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Push_Present)


/*
 回跳到某些类，可传入vc，class，array[class|vc]，array的话，先传的优先级高。
 级别，传入@(x)，正数是navi栈正序（0的话是根vc），负数是navi栈倒序（-1是上一页面）。
 */
- (void)popToViewController:(id)someViewController;

// 判断导航器的堆栈内是否有某个vc
- (BOOL)isExistedViewController:(Class)targetClass;

@end
