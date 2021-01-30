//
//  UITapGestureRecognizer+Block.m
//  nav
//
//  Created by 吕冬剑 on 2020/9/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import "UITapGestureRecognizer+Block.h"
#import <objc/runtime.h>


static NSString *const blockKey = @"blockKey";

@implementation UITapGestureRecognizer (Block)

-(void)touchActionBlock:(TouchBlock)block{
    
    objc_removeAssociatedObjects(self);
    
    [self addTarget:self action:@selector(touchAction:)];
    objc_setAssociatedObject(self, (__bridge const void *)(blockKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)touchAction:(UITapGestureRecognizer *)sender{
    
    TouchBlock block = objc_getAssociatedObject(self, (__bridge const void *)(blockKey));
    if(block){
        block(self);
    }
}

-(void)removeActionBlock{
    [self removeTarget:self action:@selector(touchAction:)];
    objc_removeAssociatedObjects(self);
}

@end
