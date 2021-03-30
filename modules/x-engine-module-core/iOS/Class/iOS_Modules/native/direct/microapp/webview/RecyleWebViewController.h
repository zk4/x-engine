#import <UIKit/UIKit.h>

@interface RecyleWebViewController : UIViewController

- (instancetype _Nonnull )initWithUrl:(NSString * _Nullable)fileUrl host:(NSString * _Nullable)host  pathname:(NSString * _Nullable)pathname newWebView:(int)newWebView withHiddenNavBar:(NSString*)isHidden;

@end
