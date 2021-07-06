//
//  iUI.h
//  ModuleApp
//
//  Created by wuzheng on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 
@protocol iUI <NSObject>
- (void)setNavBarHidden:(BOOL)isHidden isAnimation:(BOOL)isAnimation;
- (void)setNavTitle:(NSString *)title withTitleColor:(NSString *)color withTitleSize:(NSInteger)size;
- (void) alert:(NSString*) msg;
@end

NS_ASSUME_NONNULL_END
