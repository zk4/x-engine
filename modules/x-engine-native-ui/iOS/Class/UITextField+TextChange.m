//
//  UITextField+TextChange.m
//  WuYan
//
//  Created by 吕冬剑 on 2017/10/17.
//  Copyright © 2017年 LvDvJ. All rights reserved.
//

#import "UITextField+TextChange.h"
#import <objc/runtime.h>
 
 
static NSString *const beginKey = @"beginKey";
static NSString *const blockKey = @"blockKey";
static NSString *const endBlockKey = @"endBlockKey";
@implementation UITextField (TextChange)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                               selector:@selector(beginChange:)
                                   name:UITextFieldTextDidBeginEditingNotification
                                 object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self
                               selector:@selector(valueChange:)
                                   name:UITextFieldTextDidChangeNotification
                                 object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self
                               selector:@selector(endChange:)
                                   name:UITextFieldTextDidEndEditingNotification
                                 object:self];
    }
    return self;
}

-(void)addBeginBlock:(textChangeBlock)block{
    
//    objc_removeAssociatedObjects(self);
    objc_setAssociatedObject(self, (__bridge const void *)(beginKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)addChangeBlock:(textChangeBlock)block{
    
//    objc_removeAssociatedObjects(self);
    objc_setAssociatedObject(self, (__bridge const void *)(blockKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)addChangeBlock:(textChangeBlock)block addEndBlock:(textChangeBlock)endBlock{
    
//    objc_removeAssociatedObjects(self);
    objc_setAssociatedObject(self, (__bridge const void *)(blockKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)(endBlockKey), endBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)remBtnBlock{
    objc_removeAssociatedObjects(self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)beginChange:(NSNotification *)sender{
    
    if(sender.object == self){
        textChangeBlock block = objc_getAssociatedObject(self, (__bridge const void *)(beginKey));
        if(block){
            block(sender.object);
        }
    }
}

-(void)valueChange:(NSNotification *)sender{
    
    if(sender.object == self){
        textChangeBlock block = objc_getAssociatedObject(self, (__bridge const void *)(blockKey));
        if(block){
            block(sender.object);
        }
    }
}

-(void)endChange:(NSNotification *)sender{
    
    if(sender.object == self){
        textChangeBlock block = objc_getAssociatedObject(self, (__bridge const void *)(endBlockKey));
        if(block){
            block(sender.object);
        }
    }
}

-(void)dealloc{
    [self remBtnBlock];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
