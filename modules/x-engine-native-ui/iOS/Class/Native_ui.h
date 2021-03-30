//
//  Native_ui.h
//  ui
//
//  Copyright © 2020 @zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NativeModule.h"

NS_ASSUME_NONNULL_BEGIN
@interface Native_ui : NativeModule
- (void)setNavBarHidden:(BOOL)isHidden isAnimation:(BOOL)isAnimation;
- (void)setNavTitle:(NSString *)title withTitleColor:(NSString *)color withTitleSize:(NSInteger)size;

@end

NS_ASSUME_NONNULL_END
