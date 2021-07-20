#import <UIKit/UIKit.h>
@class XEngineWebView;
@interface RecyleWebViewController : UIViewController
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                      XEngineWebView:(XEngineWebView * _Nullable) webview
                    withHiddenNavBar:(BOOL)isHidden;
 
- (XEngineWebView*) getWebView;
@end
