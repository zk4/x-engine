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


//+(void)addTestFunc:(Class)class withOldSel:(SEL)oldSel withNewSel:(SEL)newSel{
//
//    Method origMethod = class_getClassMethod(class, oldSel);
//    Method altMethod = class_getClassMethod(class, newSel);
//
//    if (!origMethod || !altMethod) {
//        return;
//    }
//    Class metaClass = object_getClass(class);
//    BOOL didAddMethod = class_addMethod(metaClass,
//                                        oldSel,
//                                        method_getImplementation(altMethod),
//                                        method_getTypeEncoding(altMethod));
//
//    if (didAddMethod) {
//        class_replaceMethod(metaClass,
//                            newSel,
//                            method_getImplementation(origMethod),
//                            method_getTypeEncoding(origMethod));
//    } else {
//        method_exchangeImplementations(origMethod, altMethod);
//    }
//}
//+(void)addTestInstanceFunc:(Class)class withOldSel:(SEL)oldSel withNewSel:(SEL)newSel{
//
//    Method origMethod = class_getInstanceMethod(class, oldSel);
//    Method altMethod = class_getInstanceMethod(class, newSel);
//    if (!origMethod || !altMethod) {
//        return;
//    }
//    Class metaClass = class;
//    BOOL didAddMethod = class_addMethod(metaClass,
//                                        oldSel,
//                                        method_getImplementation(altMethod),
//                                        method_getTypeEncoding(altMethod));
//
//    if (didAddMethod) {
//        class_replaceMethod(metaClass,
//                            newSel,
//                            method_getImplementation(origMethod),
//                            method_getTypeEncoding(origMethod));
//    } else {
//        method_exchangeImplementations(origMethod, altMethod);
//    }
//}


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

- (void)pushViewControllerWithUrl:(NSString *)url withParams:(NSString *)params{

    [[ZKPushAnimation instance] isOpenCustomAnimation:[XEOneWebViewPool sharedInstance].inSingle withNavigationController:[Unity sharedInstance].getCurrentVC.navigationController];
    
    [Unity sharedInstance].getCurrentVC.hidesBottomBarWhenPushed = YES;
    url = [[XEOneWebViewControllerManage sharedInstance] getUrl:url params:params];
    
    UIViewController *vc = [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:url];
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
    
    UINavigationController *nav = [Unity sharedInstance].getCurrentVC.navigationController;

    [nav setXEPopDelegate:^BOOL(BOOL animated) {
        
        if([[Unity sharedInstance].getCurrentVC isKindOfClass:[RecyleWebViewController class]]){

            RecyleWebViewController *topVc = (RecyleWebViewController *)[Unity sharedInstance].getCurrentVC;
            if(topVc.webview.backForwardList.backList.count > 1){
                
                if([XEOneWebViewPool sharedInstance].inSingle && [Unity sharedInstance].getCurrentVC.navigationController.viewControllers.count >= 2){
                    UIViewController *toVc = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers[[Unity sharedInstance].getCurrentVC.navigationController.viewControllers.count - 2];
                    if([toVc isKindOfClass:[RecyleWebViewController class]]){
                        RecyleWebViewController *toWebVc = (RecyleWebViewController *)toVc;
                        NSString *path = [topVc.webview.backForwardList.backList.lastObject.URL absoluteString];
                         if([path isEqualToString:toWebVc.fileUrl] || [path isEqualToString:[NSString stringWithFormat:@"%@#/", toWebVc.fileUrl]]){
                            return YES;
                        }
                    }
                }
                [topVc.webview goBack];
                return NO;
            } else{
                return YES;
            }
        }
        return YES;
    }];
}

- (void)pushViewControllerWithAppid:(NSString *)appid withParams:(NSString *)params{
    long version;
    NSString *urlStr = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:appid out_version:&version];
    [self pushViewControllerWithUrl:urlStr withParams:nil];
}

-(NSString *)setMainUrl:(NSString *)url{
    
    if(![url hasSuffix:@"index.html"] && ![url hasSuffix:@"index.html/"]){
        if([url hasSuffix:@"/"])
            url = [NSString stringWithFormat:@"%@index.html", url];
        else
            url = [NSString stringWithFormat:@"%@/index.html", url];
    }
    self.rootUrl = url;
    [self createCacheVC];
    return url;
}

-(void)setMainAppid:(NSString *)appid withPath:(NSString *)path{
    
    long version;
    NSString *toUrl = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:appid out_version:&version];
    NSString *fullpath;
    if (path.length > 0){
        fullpath = [NSString stringWithFormat:@"%@%@", toUrl, path];
    } else {
        fullpath = toUrl;
    }
    [self setMainUrl:fullpath];
}

-(NSString *)getUrl:(NSString *)url params:(NSString *)params{
    NSString *toUrl;
    if ([[url lowercaseString] hasPrefix:@"http"]){
        toUrl = url;
    } else if (url.length > 0){
        
        toUrl = [self.rootUrl stringByAppendingFormat:@"#%@", url];
        
        if(params){
            NSRange range = [toUrl rangeOfString:@"?" options:NSBackwardsSearch];
            toUrl = [toUrl stringByAppendingFormat:@"%@params=%@", range.location == NSNotFound ? @"?" : @"&", params];
        }
    } else {
        toUrl = self.rootUrl;
    }
    return toUrl;
}

-(UIViewController *)getWebViewControllerWithUrl:(NSString *)url{

    XEOneRecyleWebViewController *vc = [[XEOneRecyleWebViewController alloc] initWithUrl:url withIsRoot:[url isEqualToString:self.rootUrl]];
    return vc;
}

-(UIViewController *)getWebViewControllerWithId:(NSString *)appid{
    
    long version;
    NSString* toUrl = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:appid out_version:&version];
    XEOneRecyleWebViewController *vc = [[XEOneRecyleWebViewController alloc] initWithUrl:toUrl];
    return vc;
}


-(void)createCacheVC{
    [[XEOneWebViewPool sharedInstance] createNewWebView:self.rootUrl];
}

@end
