//
//  UIBlockButton.h
//  AFNetworking
//
//  Created by zk on 2020/9/3.
//

#import <Foundation/Foundation.h>

@class UIBlockButton;
typedef void (^ActionBlock)(UIBlockButton *);

@interface UIBlockButton : UIButton {
    ActionBlock _actionBlock;
}

 -(void) handleControlEvent:(UIControlEvents)event
                  withBlock:(ActionBlock) action;
 @end


