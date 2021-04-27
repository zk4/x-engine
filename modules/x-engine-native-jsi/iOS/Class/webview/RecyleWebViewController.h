#import <UIKit/UIKit.h>

@interface RecyleWebViewController : UIViewController
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                                host:(NSString * _Nullable)host
                            pathname:(NSString * _Nullable)pathname
                            fragment:(NSString * _Nullable)fragment newWebView:(BOOL)newWebView withHiddenNavBar:(BOOL)isHidden onTab:(BOOL)isOnTab ;


- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl host:(NSString * _Nullable)host  pathname:(NSString * _Nullable)pathname fragment:(NSString * _Nullable)fragment newWebView:(BOOL)newWebView withHiddenNavBar:(BOOL)isHidden;
@end
