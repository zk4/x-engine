//
//  UIButton+VEU_Block.h
//  ViedoEditUtil
//
//  Created by 吕冬剑 on 2017/1/9.
//  Copyright © 2017年 LDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (VEU_Block)

//-(void)addBtnBlock:(UIButton *)btn block:(void(^)(UIButton *sender))block;
-(void)addBtnBlock:(void(^)(UIButton *sender))block;
-(void)remBtnBlock;
-(void)isCanClick:(BOOL)isCanClick;
-(void)isRightCanClick:(BOOL)isCanClick;
-(void)isCanClickState:(BOOL)isCanClickState;
-(void)isCanClickAnimation:(BOOL)isCanClick;
@end
