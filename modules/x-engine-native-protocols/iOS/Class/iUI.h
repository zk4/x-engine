//
//  iUI.h
//  ModuleApp
//
//  Created by wuzheng on 2021/3/23.
//  Copyright © 2021 x-engine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 
@protocol iUI <NSObject>
- (void)setNavBarHidden:(BOOL)isHidden isAnimation:(BOOL)isAnimation;
- (void)setNavTitle:(NSString *)title withTitleColor:(NSString *)color withTitleSize:(NSInteger)size;
@end

NS_ASSUME_NONNULL_END
