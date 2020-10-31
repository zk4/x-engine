#import "XEOneWebViewControllerManage.h"
#import "XEOneRecyleWebViewController.h"
#import "XEOneWebViewPool.h"
#import "MicroAppLoader.h"
#import "Unity.h"
#import "ZKPushAnimation.h"
#import <objc/runtime.h>

#import "UINavigationController+Customized.h"


@interface XEOneWebViewControllerManage ()

@property (nonatomic, strong) XEOneRecyleWebViewController *vc;
@property (nonatomic, copy) NSString *rootUrl;
@property (nonatomic, strong) NSMutableDictionary *animationDic;
@end


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

 

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animationDic = [@{} mutableCopy];
        self.rootUrl = @"";
    }
    return self;
}

-(void)isSingleWebView:(BOOL)isSingle{
    
    [XEOneWebViewPool sharedInstance].inSingle = isSingle;
}

- (void)pushWebViewControllerWithUrl:(NSString *)url{
    
    UIViewController *vc = [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:url];
    [[ZKPushAnimation instance] isOpenCustomAnimation:[XEOneWebViewPool sharedInstance].inSingle withFrom:[Unity sharedInstance].getCurrentVC withTo:vc];
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
}

- (void)pushViewControllerWithPath:(NSString *)path withParams:(NSString *)params{
    
    [Unity sharedInstance].getCurrentVC.hidesBottomBarWhenPushed = YES;
    NSString *url = [self getUrl:path params:params];
    
    UIViewController *vc = [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:url];
    
    [[ZKPushAnimation instance] isOpenCustomAnimation:[XEOneWebViewPool sharedInstance].inSingle withFrom:[Unity sharedInstance].getCurrentVC withTo:vc];
    
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
}

- (void)pushViewControllerWithAppid:(NSString *)appid withVersion:(long)version withPath:(NSString *)path withParams:(NSString *)params{

    NSString *urlStr = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:appid in_version:version ];
    if(urlStr){
        [self setMainUrl:urlStr];
        [self pushWebViewControllerWithUrl:[NSString stringWithFormat:@"%@?/#%@", urlStr,path]];
    }
}
//-(NSString*) normalizeUrl:(NSString*)url{
//    NSURLComponents *components = [[NSURLComponents alloc] initWithString:url];
////    return [NSString stringWithFormat:@"%@://%@:%@/%@",]
//    return @"";
//}
-(NSString *)setMainUrl:(NSString *)url{
//    [self normalizeUrl:url];
    if([url rangeOfString:@".html"].location == NSNotFound){
        if(![url hasSuffix:@"index.html"] && ![url hasSuffix:@"index.html/"]){
            if([url hasSuffix:@"/"])
                url = [NSString stringWithFormat:@"%@index.html", url];
            else
                url = [NSString stringWithFormat:@"%@/index.html", url];
        }
    }
    self.rootUrl = url;
    [self createCacheVC];
    return url;
}

-(void)setMainAppid:(NSString *)appid withPath:(NSString *)path{
    

    NSString *toUrl = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:appid in_version:0  ];
    NSString *fullpath;
    if (path.length > 0){
        fullpath = [NSString stringWithFormat:@"%@%@", toUrl, path];
    } else {
        fullpath = toUrl;
    }
    [self setMainUrl:fullpath];
}

-(NSString *)getUrl:(NSString *)url params:(NSString *)params{
    NSMutableString *toUrl = [[NSMutableString alloc] init];
    if ([[url lowercaseString] hasPrefix:@"http"]){
        [toUrl appendString:url];
    } else if (url.length > 0){
        [toUrl appendFormat:@"%@#%@", self.rootUrl, url];
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
        [toUrl appendString:self.rootUrl];
    }
    return toUrl;
}

-(UIViewController *)getWebViewControllerWithUrl:(NSString *)url{
    XEOneRecyleWebViewController *vc = [[XEOneRecyleWebViewController alloc] initWithUrl:url withRootPath:nil];
    return vc;
}

-(UIViewController *)getWebViewControllerWithId:(NSString *)appid{
    NSString* toUrl = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:appid in_version:0 ];
    XEOneRecyleWebViewController *vc = [[XEOneRecyleWebViewController alloc] initWithUrl:toUrl];
    return vc;
}


-(void)createCacheVC{
    [[XEOneWebViewPool sharedInstance] createNewWebView:self.rootUrl];
}

@end
