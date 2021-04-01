//
//  WebViewPool.m
//  x-engine-module-engine


#import "WebViewFactory.h"
#import "XEngineWebView.h"
#import "JSIContext.h"
#import "MicroAppLoader.h"
#import "JSIModule.h"

#import "Unity.h"
#import "RecyleWebViewController.h"
#import "CustomURLSchemeHandler.h"


@interface WebViewFactory ()

@property (nonatomic, strong) WKProcessPool* wkprocessPool;
@end

@implementation WebViewFactory

+ (instancetype)sharedInstance
{
    static WebViewFactory *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WebViewFactory alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    self = [super init];
    if (self){
        self.wkprocessPool = [[WKProcessPool alloc] init];
        self.webviews = [@[] mutableCopy];

    }
    return self;
}
//
//
//- (WebViewFactoryModel *)getModelWithWeb:(WKWebView *)webView{
//
//    for (WebViewFactoryModel *model in self.webCacheAry) {
//        if(model.webView == webView) {
//            return model;
//        }
//    }
//    return nil;
//}
///TODO:  webviewpool 需要重新设计 api, baseUrl 没有意义
-(XEngineWebView *)createWebView{
    
//    WebViewFactoryModel *model = [[WebViewFactoryModel alloc] init];
    
/// TODO: 这里为什么会有这种逻辑？
//    if([baseUrl hasPrefix:@"file://"]){
//        NSString *filePath = [baseUrl substringFromIndex:7];
//        NSString *rootPath;
//        NSString *rootFile;
//        NSString *appId;
//        if([filePath hasPrefix:[[MicroAppLoader sharedInstance] microappDirectory]]){
//            rootFile = [filePath substringFromIndex:[[MicroAppLoader sharedInstance] microappDirectory].length + 1];
//            NSArray *ary = [rootFile pathComponents];
//            if(ary.count > 0){
//                appId = ary.firstObject;
//                rootPath = [[[MicroAppLoader sharedInstance] microappDirectory] stringByAppendingPathComponent:appId];
//            }
//        }else if([filePath hasPrefix:[[NSBundle mainBundle] resourcePath]]){
//            rootFile = [filePath substringFromIndex:[[NSBundle mainBundle] resourcePath].length + 1];
//            NSArray *ary = [rootFile pathComponents];
//            if(ary.count > 0){
//                appId = ary.firstObject;
//                rootPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:appId];
//            }
//        }
//        NSString *profilePath = [rootPath stringByAppendingPathComponent:@"microapp.json"];
//        if([[NSFileManager defaultManager] fileExistsAtPath:profilePath]){
//            NSData *jsonData = [NSData dataWithContentsOfFile:profilePath];
//            NSDictionary *profileDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//            NSDictionary *permission = profileDic[@"permission"];
//            model.secrect = permission[@"secrect"];
//            NSDictionary *network = profileDic[@"network"];
//            model.isStrict = [network[@"strict"] boolValue];
//            model.whiteList = network[@"white_host_list"];
//
//            NSArray<NSString *> *ary = [appId componentsSeparatedByString:@"."];
//            model.version = [ary.lastObject integerValue];
//            model.appId = [appId substringToIndex:ary.lastObject.length + 1];
//            model.appRootPath = rootPath;
//        }
//    }
    
    NSMutableArray *modules = [[JSIContext sharedInstance] modules];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.processPool = self.wkprocessPool;

    if (@available(iOS 11.0, *) ) {
//        CustomURLSchemeHandler *handler = [CustomURLSchemeHandler new];
//        [configuration setURLSchemeHandler:handler forURLScheme:@"https"];
//        [configuration setURLSchemeHandler:handler forURLScheme:@"http"];
    }
    XEngineWebView* webview = [[XEngineWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    webview.configuration.preferences.javaScriptEnabled = YES;
    webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    [webview.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    [webview.configuration setValue:@YES forKey:@"allowUniversalAccessFromFileURLs"];
    
    for (JSIModule *baseModule in modules){
        [webview addJavascriptObject:baseModule namespace:baseModule.moduleId];
    }
    [webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//    model.webView = webview;
    [self.webviews addObject:webview];
    return webview;
}
//
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        float floatNum = [[change objectForKey:@"new"] floatValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"XEWebViewProgressChangeNotification" object:@{
            @"progress":@(floatNum),
            @"webView":object,
        }];
        if (floatNum >= 1) {
            [object removeObserver:self forKeyPath:@"estimatedProgress"];
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if([change objectForKey:@"new"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"XEWebViewProgressChangeNotification" object:@{
                @"title":[change objectForKey:@"new"],
                @"webView":object,
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end


