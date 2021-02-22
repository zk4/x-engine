#import <Foundation/Foundation.h>
 

@import WebKit;

@interface XEOneWebViewControllerManage : NSObject

+ (instancetype)sharedInstance;

- (void)setMainAppid:(NSString *)appid withPath:(NSString *)path;

- (UIViewController *)getWebViewControllerWithUrl:(NSString *)url;
- (UIViewController *)getWebViewControllerWithId:(NSString *)appid;


- (void)pushWebViewControllerWithHttpRouteUrl:(NSString *)url;
//增加是否显示导航栏
- (void)pushWebViewControllerWithHttpRouteUrl:(NSString *)url isHiddenNavbar:(BOOL)isHidden;
//nav用
- (void)pushViewControllerWithPath:(NSString *)path withParams:(NSString *)params;
- (void)pushViewControllerWithPath:(NSString *)path withParams:(NSString *)params withHiddenNavbar:(BOOL)isHidden;
//route用
- (void)pushViewControllerWithAppid:(NSString *)appid
                           withPath:(NSString *)path
                        withVersion:(long)version
                         withParams:(NSString *)params;
- (void)pushViewControllerWithAppid:(NSString *)appid
                           withPath:(NSString *)path
                        withVersion:(long)version
                         withParams:(NSString *)params
                 withIsHiddenNavbar:(BOOL)isHidden;
@end


