#import <UIKit/UIKit.h>

@interface RecyleWebViewController : UIViewController
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                                host:(NSString * _Nullable)host
                            pathname:(NSString * _Nullable)pathname
                            fragment:(NSString * _Nullable)fragment   withHiddenNavBar:(BOOL)isHidden onTab:(BOOL)isOnTab;

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                                host:(NSString * _Nullable)host
                            pathname:(NSString * _Nullable)pathname
                            query:(NSMutableDictionary *_Nullable)query
                            fragment:(NSString * _Nullable)fragment   withHiddenNavBar:(BOOL)isHidden onTab:(BOOL)isOnTab;

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl host:(NSString * _Nullable)host  pathname:(NSString * _Nullable)pathname fragment:(NSString * _Nullable)fragment   withHiddenNavBar:(BOOL)isHidden;
@end
