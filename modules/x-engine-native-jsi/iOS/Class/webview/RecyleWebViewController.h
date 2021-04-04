#import <UIKit/UIKit.h>
#import "XEngineWebView.h"
@interface RecyleWebViewController : UIViewController

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl host:(NSString * _Nullable)host  fragment:(NSString * _Nullable)fragment webview:(XEngineWebView*)webview withHiddenNavBar:(BOOL)isHidden;
@end
