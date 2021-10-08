#import <UIKit/UIKit.h>
#import <x-engine-native-protocols/iContainer.h>
@class XEngineWebView;
@interface RecyleWebViewController : UIViewController<iContainer>
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden;


- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame;


- (XEngineWebView* _Nonnull) getWebView;
@end
