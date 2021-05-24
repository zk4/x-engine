//
//  Native_ui.h
//  ui
//
//  Copyright © 2020 @zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XENativeModule.h"
#import "iUI.h"
NS_ASSUME_NONNULL_BEGIN
@interface Native_ui : XENativeModule <iUI>
- (void)setNavBarHidden:(BOOL)isHidden isAnimation:(BOOL)isAnimation;
- (void)setNavTitle:(NSString *)title withTitleColor:(NSString *)color withTitleSize:(NSInteger)size;

@end

NS_ASSUME_NONNULL_END
