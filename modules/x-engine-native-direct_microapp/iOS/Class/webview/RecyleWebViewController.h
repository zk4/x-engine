#import <UIKit/UIKit.h>

@interface RecyleWebViewController : UIViewController

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl host:(NSString * _Nullable)host  fragment:(NSString * _Nullable)fragment newWebView:(BOOL)newWebView withHiddenNavBar:(BOOL)isHidden;
@end
