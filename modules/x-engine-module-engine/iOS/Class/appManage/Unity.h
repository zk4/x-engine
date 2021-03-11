//
//  Unity.h
//  XEngine


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WKWebView;
@interface Unity : NSObject

@property (nonatomic, weak) WKWebView *XXXWeb;
//+ (NSString *)getAppKey:(NSString *)appSecret MicroApp:(NSString *)microapp;
+ (Unity *)sharedInstance;
- (UIView *)topView;
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC;

;
@end


