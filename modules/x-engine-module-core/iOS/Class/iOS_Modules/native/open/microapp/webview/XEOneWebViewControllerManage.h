#import <Foundation/Foundation.h>


@import WebKit;

@interface XEOneWebViewControllerManage :NSObject

+ (instancetype)sharedInstance;
//
////router push HTTP
//- (void)pushWebViewControllerWithHttpRouteUrl:(NSString *)url;
//
////nav用 push下一级
//- (void)pushViewControllerWithPath:(NSString *)path
//                        withParams:(NSString *)params;
//
- (void)pushViewControllerWithPath:(NSString *)path
                        withParams:(NSString *)params
                  withHiddenNavbar:(BOOL)isHidden;
//
////router push MicroApp
//- (void)pushViewControllerWithAppid:(NSString *)appid
//                           withPath:(NSString *)path
//                        withVersion:(long)version
//                         withParams:(NSString *)params;
//- (void)pushViewControllerWithAppid:(NSString *)appid
//                           withPath:(NSString *)path
//                        withVersion:(long)version
//                         withParams:(NSString *)params
//                 withIsHiddenNavbar:(BOOL)isHidden;

@end


