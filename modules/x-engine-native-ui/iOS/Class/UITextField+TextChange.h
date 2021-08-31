//
//  UITextField+TextChange.h
//  WuYan
//
//  Created by 吕冬剑 on 2017/10/17.
//  Copyright © 2017年 LvDvJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^textChangeBlock)(UITextField *sender);

@interface UITextField (TextChange)

-(void)addBeginBlock:(textChangeBlock)block;
-(void)addChangeBlock:(textChangeBlock)block;
-(void)addChangeBlock:(textChangeBlock)block addEndBlock:(textChangeBlock)endBlock;
-(void)remBtnBlock;

@end
