//
//  MBProgressHUD+Toast.h
//  XEngine

#import <Foundation/Foundation.h>
@class MBProgressHUD;

@interface MBProgressHUD (Toast)
+ (MBProgressHUD *)showToastWithTitle:(NSString *)title image:(UIImage *)image time:(NSTimeInterval)time;
@end


