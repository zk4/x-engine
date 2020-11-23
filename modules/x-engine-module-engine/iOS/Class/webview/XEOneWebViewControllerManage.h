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
//nav用
- (void)pushViewControllerWithPath:(NSString *)path withParams:(NSString *)params;
//route用
- (void)pushViewControllerWithAppid:(NSString *)appid
                           withPath:(NSString *)path
                        withVersion:(long)version
                         withParams:(NSString *)params;

@end


