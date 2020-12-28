#import "XEOneWebViewControllerManage.h"
#import "RecyleWebViewController.h"
#import "XEOneWebViewPool.h"
#import "MicroAppLoader.h"
#import "Unity.h"
#import "ZKPushAnimation.h"
#import <objc/runtime.h>

#import "UINavigationController+Customized.h"



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
    
    [[XEOneWebViewPool sharedInstance] createNewWebView:url];
    [self pushWebViewControllerWithUrl:url];
}
//http用
- (void)pushWebViewControllerWithUrl:(NSString *)url{
    
    [self pushWebViewControllerWithUrl:url withIsHiddenNavbar:NO];
}

- (void)pushWebViewControllerWithUrl:(NSString *)url withIsHiddenNavbar:(BOOL)isHidden{
    
    UIViewController *vc = [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:url];
    [[ZKPushAnimation instance] isOpenCustomAnimation:[XEOneWebViewPool sharedInstance].inSingle withFrom:[Unity sharedInstance].getCurrentVC withTo:vc];
    
//    UIView *vv = [[UIView alloc] init];
//    [UIApplication sharedApplication].keyWindow
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
}
//nav用
- (void)pushViewControllerWithPath:(NSString *)path withParams:(NSString *)params{
    
    [Unity sharedInstance].getCurrentVC.hidesBottomBarWhenPushed = YES;
    NSString *url = [self getUrl:path params:params];
    
    UIViewController *vc = [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:url];
    //
    [[ZKPushAnimation instance] isOpenCustomAnimation:[XEOneWebViewPool sharedInstance].inSingle
                                             withFrom:[Unity sharedInstance].getCurrentVC withTo:vc];
    
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
}
//route用
- (void)pushViewControllerWithAppid:(NSString *)appid
                           withPath:(NSString *)path
                        withVersion:(long)version
                         withParams:(NSString *)params{
    
    [self pushViewControllerWithAppid:appid withPath:path withVersion:version withParams:params withIsHiddenNavbar:NO];
}

- (void)pushViewControllerWithAppid:(NSString *)appid
                           withPath:(NSString *)path
                        withVersion:(long)version
                         withParams:(NSString *)params
                 withIsHiddenNavbar:(BOOL)isHidden{
    
    NSString *urlStr = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:appid in_version:version];
    [[XEOneWebViewPool sharedInstance] createNewWebView:urlStr];
    if(urlStr){
        if(path.length > 0){
            urlStr = [NSString stringWithFormat:@"%@%@%@%@", urlStr, ([urlStr hasSuffix:@"index.html"] ? @"#" : @""), ([urlStr hasSuffix:@"/"] || [path hasPrefix:@"/"]) ? @"" : @"/", path];
            if([urlStr rangeOfString:@"?"].location != NSNotFound){
                urlStr = [NSString stringWithFormat:@"%@&sssxxxDate=%@", urlStr, @([[NSDate date] timeIntervalSince1970])];
            }else{
                urlStr = [NSString stringWithFormat:@"%@?sssxxxDate=%@", urlStr, @([[NSDate date] timeIntervalSince1970])];
            }
        }
        [self pushWebViewControllerWithUrl:urlStr withIsHiddenNavbar:isHidden];
    }
}

-(void)setMainAppid:(NSString *)appid withPath:(NSString *)path{
    
    NSString *toUrl = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:appid in_version:1];
    NSString *fullpath;
    if (path.length > 0){
        fullpath = [NSString stringWithFormat:@"%@%@", toUrl, path];
    } else {
        fullpath = toUrl;
    }
}

-(NSString *)getUrl:(NSString *)url params:(NSString *)params{
    NSMutableString *toUrl = [[NSMutableString alloc] init];
    
    RecyleWebViewController *web = (RecyleWebViewController *)[Unity sharedInstance].getCurrentVC;
    NSRange range = [[web loadUrl] rangeOfString:@"index.html"];
    NSString *host = [[web loadUrl] substringToIndex:range.location + range.length];
    
    if ([[url lowercaseString] hasPrefix:@"http"]){
        [toUrl appendString:url];
    } else if (url.length > 0){
        
        [toUrl appendFormat:@"%@#%@", host, url];
        if(params){
            if([params isKindOfClass:[NSString class]]){
                NSRange range = [toUrl rangeOfString:@"?" options:NSBackwardsSearch];

                [toUrl appendFormat:@"%@%@", range.location == NSNotFound ? @"?" : @"&", params];
            }else if([params isKindOfClass:[NSDictionary class]]){
                NSRange range = [toUrl rangeOfString:@"?" options:NSBackwardsSearch];
                if(range.location == NSNotFound){
                    [toUrl appendString:@"?"];
                } else{
                    [toUrl appendString:@"&"];
                }
                NSDictionary *dic = (NSDictionary *)params;
                for (NSString *key in [dic allKeys]) {
                    [toUrl appendFormat:@"&%@=%@", key, dic[key]];
                }
            }
        }
    } else {
        [toUrl appendString:host];
    }
    return toUrl;
}

-(UIViewController *)getWebViewControllerWithUrl:(NSString *)url{
    return [self getWebViewControllerWithUrl:url withHiddenBar:NO];
}
-(UIViewController *)getWebViewControllerWithUrl:(NSString *)url withHiddenBar:(BOOL)isHidden{
    RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:url withRootPath:nil withHiddenNavBar:isHidden];
    return vc;
}

-(UIViewController *)getWebViewControllerWithId:(NSString *)appid{
    
    NSString* toUrl = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:appid in_version:1];
    RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:toUrl];
    return vc;
}

@end
