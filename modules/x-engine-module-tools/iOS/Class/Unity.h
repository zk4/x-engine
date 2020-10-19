//
//  Unity.h
//  XEngine


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Unity : NSObject

@property (nonatomic, copy) NSString *nowMicroAppId;
//+ (NSString *)getAppKey:(NSString *)appSecret MicroApp:(NSString *)microApp;
+ (Unity *)sharedInstance;
- (UIView *)topView;
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC;

@end


