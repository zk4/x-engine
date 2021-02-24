//
//  ZKTabBar.m
//  xxxx
//
//  Created by 李宫 on 2021/2/1.
//  Copyright © 2021 zk. All rights reserved.
//

#import "ZKTabBar.h"
#define SAFE_AREA_INSETS               [[[[UIApplication sharedApplication] delegate] window] safeAreaInsets]

@interface ZKTabBar ()

@end


@implementation ZKTabBar

- (instancetype)init{
    self = [super init];
    if (self) {
        self.unselectedItemTintColor = [UIColor colorWithRed:18/255.0 green:18/255.0 blue:18/255.0 alpha:1/1.0];
        self.tintColor = [UIColor colorWithRed:251/255.0 green:151/255.0 blue:0/255.0 alpha:1/1.0];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"plus_Last"] forState:UIControlStateNormal];
        btn.bounds = CGRectMake(0, 0, 72, 72);
        self.centerBtn = btn;
        [self addSubview:btn];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.centerBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.1);
    
    int index = 0;
    CGFloat wigth = self.bounds.size.width / 5;
    
    for (UIView* sub in self.subviews) {
        
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (@available(iOS 11.0, *)) {
                if (SAFE_AREA_INSETS.bottom >0.0) {
                    sub.frame = CGRectMake(index * wigth, self.bounds.origin.y, wigth, self.bounds.size.height - SAFE_AREA_INSETS.bottom);
                }else{
                    sub.frame = CGRectMake(index * wigth, self.bounds.origin.y, wigth, self.bounds.size.height - 2);
                }
            }else{
                sub.frame = CGRectMake(index * wigth, self.bounds.origin.y, wigth, self.bounds.size.height - 2);
            }
            
            index++;
            
            if (index == 2) {
                index++;
            }
        }
    }
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.centerBtn];
        
        if ( [self.centerBtn pointInside:newPoint withEvent:event]) {
            return self.centerBtn;
        }else{
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {
        return [super hitTest:point withEvent:event];
    }
    
    
}

@end
