//
//  NavUtil.h
//  nav
//
//  Created by 吕冬剑 on 2020/9/15.
//  Copyright © 2020 @zkty-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavUtil : NSObject
+ (void)setNavBarHidden:(BOOL)isHidden isAnimation:(BOOL)isAnimation;
+ (void)setNavTitle:(NSString *)title withTitleColor:(NSString *)color withTitleSize:(NSInteger)size;
@end