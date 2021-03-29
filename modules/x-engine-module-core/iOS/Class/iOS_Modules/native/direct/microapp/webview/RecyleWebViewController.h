#import <UIKit/UIKit.h>

@interface RecyleWebViewController : UIViewController

- (instancetype _Nonnull )initWithUrl:(NSString * _Nullable)fileUrl host:(NSString * _Nullable)host  path:(NSString * _Nullable)path newWebView:(Boolean)newWebView withHiddenNavBar:(BOOL)isHidden;

@end
