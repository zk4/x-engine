//
//  Unity.h
//  XEngine


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WKWebView;
@interface Unity : NSObject
@property (nonatomic, weak) WKWebView *XXXWeb;
+ (Unity *)sharedInstance;
- (UIView *)topView;
- (UIViewController *)getCurrentVC;
@end


