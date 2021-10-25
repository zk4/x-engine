#import <UIKit/UIKit.h>
#import <x-engine-native-protocols/iContainer.h>

@interface NormalWebViewController : UIViewController<iContainer>
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden;

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame;

@end
