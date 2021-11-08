
#import <UIKit/UIKit.h>
#import <x-engine-native-protocols/iContainer.h>
@interface ReactNativeViewController : UIViewController<iContainer>
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden
                        webviewFrame:(CGRect) frame
                          moduleName:(NSString *_Nullable)name;
@end
