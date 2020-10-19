//
//  Unity.h
//  XEngine


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Unity : NSObject


//+ (NSString *)getAppKey:(NSString *)appSecret MicroApp:(NSString *)microapp;
+ (Unity *)sharedInstance;
- (UIView *)topView;
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC;

@end


