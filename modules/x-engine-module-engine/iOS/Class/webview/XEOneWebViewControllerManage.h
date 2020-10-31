#import <Foundation/Foundation.h>
 

@import WebKit;

@interface XEOneWebViewControllerManage : NSObject

+ (instancetype)sharedInstance;

- (void)isSingleWebView:(BOOL)isSingle;
- (NSString *)setMainUrl:(NSString *)url;
- (void)setMainAppid:(NSString *)appid withPath:(NSString *)path;

- (NSString *)getUrl:(NSString *)url params:(NSString *)params;

- (UIViewController *)getWebViewControllerWithUrl:(NSString *)url;
- (UIViewController *)getWebViewControllerWithId:(NSString *)appid;
- (void)createCacheVC;


- (void)pushWebViewControllerWithUrl:(NSString *)url;
- (void)pushViewControllerWithPath:(NSString *)path withParams:(NSString *)params;
- (void)pushViewControllerWithAppid:(NSString *)appid withVersion:(long)version withPath:(NSString *)path withParams:(NSString *)params;
@end


