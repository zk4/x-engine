//
//  UITapGestureRecognizer+Block.h
//  nav
//
//  Created by 吕冬剑 on 2020/9/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchBlock)(UITapGestureRecognizer *);

@interface UITapGestureRecognizer (Block)

-(void)touchActionBlock:(TouchBlock)block;
-(void)removeActionBlock;

@end

