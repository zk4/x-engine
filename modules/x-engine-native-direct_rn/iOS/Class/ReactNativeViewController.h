
#import <UIKit/UIKit.h>
#import <x-engine-native-protocols/iContainer.h>
@class XEngineWebView;
@interface ReactNativeViewController : UIViewController<iContainer>
@property (nonatomic, copy) NSString * _Nullable moduleName;

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden;

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame;

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame looseNetwork:(BOOL)isLooseNetwork;

- (XEngineWebView* _Nonnull) getWebView;
@end
