//
//  UIBlockButton.m
//  AFNetworking
//
//  Created by zk on 2020/9/3.
//

#import "UIBlockButton.h"

@implementation UIBlockButton
 
-(void) handleControlEvent:(UIControlEvents)event
                 withBlock:(ActionBlock) action
{
    _actionBlock = action;
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

-(void) callActionBlock:(id)sender{
    _actionBlock(self);
}

@end
