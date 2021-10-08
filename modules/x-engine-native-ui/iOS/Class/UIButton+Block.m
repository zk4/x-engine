//
//  Created by zkty on 2017/1/9.
//  Copyright © 2017年 LDJ. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static NSString *const blockKey = @"blockKey";
@implementation UIButton (Block)


-(void)addBtnBlock:(void(^)(UIButton *sender))block{
    
    objc_removeAssociatedObjects(self);

    [self addTarget:self action:@selector(toRePwd) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, (__bridge const void *)(blockKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)toRePwd{
    
    void(^block)(UIButton *sender) = objc_getAssociatedObject(self, (__bridge const void *)(blockKey));
    if(block){
        block(self);
    }
}

-(void)remBtnBlock{
    [self removeTarget:self action:@selector(toRePwd) forControlEvents:UIControlEventTouchUpInside];
    objc_removeAssociatedObjects(self);
}



@end

