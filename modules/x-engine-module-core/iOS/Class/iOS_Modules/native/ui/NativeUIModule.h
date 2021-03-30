//
//  NativeUIModule.h
//  nav
//
//

#import <UIKit/UIKit.h>
#import "NativeModule.h"
#import "iUI.h"
@interface NativeUIModule : NativeModule <iUI>
- (void)setNavBarHidden:(BOOL)isHidden isAnimation:(BOOL)isAnimation;
- (void)setNavTitle:(NSString *)title withTitleColor:(NSString *)color withTitleSize:(NSInteger)size;
@end
