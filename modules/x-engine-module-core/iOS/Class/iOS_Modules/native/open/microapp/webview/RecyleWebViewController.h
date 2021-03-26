#import <UIKit/UIKit.h>

@class XEngineWebView;
@interface RecyleWebViewController : UIViewController

+ (XEngineWebView * _Nullable) webview;

- (instancetype _Nonnull )initWithUrl:(NSString * _Nullable)fileUrl newWebView:(Boolean)newWebView withHiddenNavBar:(BOOL)isHidden;

 
@end
