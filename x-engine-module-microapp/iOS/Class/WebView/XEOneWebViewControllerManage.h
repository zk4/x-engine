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


/**
 *  跳转至某Path地址. 让H5仿原生效果
 *
 *  跳转到指定path
 *
 *  @param url  H5中的path
 *  @param params  H5中的params, 将被拼接在完整url后面
 */
- (void)pushViewControllerWithUrl:(NSString *)url withParams:(NSString *)params;
- (void)pushViewControllerWithAppid:(NSString *)appid withParams:(NSString *)params;

@end


