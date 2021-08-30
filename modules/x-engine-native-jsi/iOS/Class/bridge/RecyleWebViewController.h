#import <UIKit/UIKit.h>
@class XEngineWebView;
@interface RecyleWebViewController : UIViewController
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden;


- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame;


- (XEngineWebView* _Nonnull) getWebView;
@end
