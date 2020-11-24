#import <Foundation/Foundation.h>
 

@import WebKit;

@interface XEOneWebViewControllerManage : NSObject

+ (instancetype)sharedInstance;

- (void)setMainAppid:(NSString *)appid withPath:(NSString *)path;

- (UIViewController *)getWebViewControllerWithUrl:(NSString *)url;
- (UIViewController *)getWebViewControllerWithId:(NSString *)appid;


- (void)pushWebViewControllerWithUrl:(NSString *)url;
//nav用
- (void)pushViewControllerWithPath:(NSString *)path withParams:(NSString *)params;
//route用
- (void)pushViewControllerWithAppid:(NSString *)appid
                           withPath:(NSString *)path
                        withVersion:(long)version
                         withParams:(NSString *)params;

@end


