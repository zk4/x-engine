#import "XEOneWebViewControllerManage.h"
#import "RecyleWebViewController.h"
#import "XEOneWebViewPool.h"
#import "NativeContext.h"
#import "Unity.h"
#import <objc/runtime.h>
#import "MicroAppLoader.h"


@implementation XEOneWebViewControllerManage

+ (instancetype)sharedInstance
{
    static XEOneWebViewControllerManage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XEOneWebViewControllerManage alloc] init];
    });
    return sharedInstance;
}
 

- (void)pushWebViewControllerWithHttpRouteUrl:(NSString *)url{
    
    [[XEOneWebViewPool sharedInstance] createWebView:url];
    [self pushWebViewControllerWithUrl:url];
}
//http用
- (void)pushWebViewControllerWithUrl:(NSString *)url{
    
    [self pushWebViewControllerWithUrl:url withIsHiddenNavbar:NO];
}

- (void)pushWebViewControllerWithUrl:(NSString *)url withIsHiddenNavbar:(BOOL)isHidden{
    
    RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:url newWebView:FALSE withHiddenNavBar:isHidden];
    vc.hidesBottomBarWhenPushed = YES;
    if([Unity sharedInstance].getCurrentVC.navigationController){
        [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];

    } else {
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        if([nav isKindOfClass:[UINavigationController class]]){
            [nav pushViewController:vc animated:YES];
        } else {
            nav = nav.navigationController;
            [nav pushViewController:vc animated:YES];
        }
    }
    vc.hidesBottomBarWhenPushed = NO;
}
//nav用
- (void)pushViewControllerWithPath:(NSString *)path withParams:(NSString *)params{
    [self pushViewControllerWithPath:path withParams:params withHiddenNavbar:NO];
}

- (void)pushViewControllerWithPath:(NSString *)path withParams:(NSString *)params withHiddenNavbar:(BOOL)isHidden{
    [Unity sharedInstance].getCurrentVC.hidesBottomBarWhenPushed = YES;
//    NSString *url = [self getUrl:path params:params];
    
    RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:path newWebView:FALSE withHiddenNavBar:isHidden];
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
}
//route用
- (void)pushViewControllerWithAppid:(NSString *)appid
                           withPath:(NSString *)path
                        withVersion:(long)version
                         withParams:(NSString *)params
                 withIsHiddenNavbar:(BOOL)isHidden{
    
    NSString *urlStr = [[MicroAppLoader sharedInstance] getMicroAppUrlStrPathWith:appid withVersion:version];
    [[XEOneWebViewPool sharedInstance] createWebView:urlStr];

    if(urlStr){
        if(path.length > 0){
            urlStr = [NSString stringWithFormat:@"%@%@%@%@", urlStr, ([urlStr hasSuffix:@"index.html"] ? @"#" : @""), ([urlStr hasSuffix:@"/"] || [path hasPrefix:@"/"]) ? @"" : @"/", path];
        
        }
        [self pushWebViewControllerWithUrl:urlStr withIsHiddenNavbar:isHidden];
    }
}

//- (void)pushViewControllerWithAppid:(NSString *)appid withPath:(NSString *)path withVersion:(long)version withParams:(NSString *)params {
//    <#code#>
//}
//
//
//-(NSString *)getUrl:(NSString *)url params:(NSString *)params{
//    NSMutableString *toUrl = [[NSMutableString alloc] init];
//
//    NSString *nowUrl = [[XEOneWebViewPool sharedInstance] nowMicroAppLoadUrl];
//
//    NSRange range = [nowUrl rangeOfString:@"index.html"];
//    NSString *host = [nowUrl substringToIndex:range.location + range.length];
//
//    if ([[url lowercaseString] hasPrefix:@"http"]){
//        [toUrl appendString:url];
//    } else if (url.length > 0){
//
//        [toUrl appendFormat:@"%@#%@", host, url];
//        if(params){
//            if([params isKindOfClass:[NSString class]]){
//                NSRange range = [toUrl rangeOfString:@"?" options:NSBackwardsSearch];
//
//                [toUrl appendFormat:@"%@%@", range.location == NSNotFound ? @"?" : @"&", params];
//            }else if([params isKindOfClass:[NSDictionary class]]){
//                NSRange range = [toUrl rangeOfString:@"?" options:NSBackwardsSearch];
//                if(range.location == NSNotFound){
//                    [toUrl appendString:@"?"];
//                } else{
//                    [toUrl appendString:@"&"];
//                }
//                NSDictionary *dic = (NSDictionary *)params;
//                for (NSString *key in [dic allKeys]) {
//                    [toUrl appendFormat:@"&%@=%@", key, dic[key]];
//                }
//            }
//        }
//    } else {
//        [toUrl appendString:host];
//    }
//    return toUrl;
//}

//-(UIViewController *)getWebViewControllerWithUrl:(NSString *)url{
//    return [self getWebViewControllerWithUrl:url withHiddenBar:NO];
//}

 
@end
