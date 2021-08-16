//
//  WebViewPool.m
//  x-engine-module-engine


#import "WebViewFactory.h"
#import "XEngineWebView.h"
#import "JSIContext.h"
#import "JSIModule.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "iWebcache.h"
#import "XENativeContext.h"


@interface WebViewFactory ()
@property (nonatomic, strong) WKProcessPool* wkprocessPool;
@end

@implementation WebViewFactory
+ (instancetype)sharedInstance {
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
        self.webviews = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsWeakMemory];
        
    }
    return self;
}

- (XEngineWebView *)createWebView {
    NSMutableArray *modules = [[JSIContext sharedInstance] modules];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.processPool = self.wkprocessPool;
    configuration.websiteDataStore = [WKWebsiteDataStore nonPersistentDataStore];
//    if (@available(iOS 11.0, *) ) {
//        CustomURLSchemeHandler *handler = [CustomURLSchemeHandler new];
//        [configuration setURLSchemeHandler:handler forURLScheme:@"https"];
//        [configuration setURLSchemeHandler:handler forURLScheme:@"http"];
//    }
    XEngineWebView* webview = [[XEngineWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        
    // 禁止回弹
    // webview.scrollView.bounces = false;

    webview.configuration.preferences.javaScriptEnabled = YES;
    webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    [webview.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    [webview.configuration setValue:@YES forKey:@"allowUniversalAccessFromFileURLs"];
    
    ///web禁止长按
    {
    NSMutableString *javascript = [NSMutableString string];
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd  forMainFrameOnly:YES];
    [webview.configuration.userContentController addUserScript:noneSelectScript];
    }
    // webcache 插件
    id<iWebcache> webcache= XENP(iWebcache);
    if(webview)
        [webcache enableXHRIntercept:webview];
    
    for (JSIModule *baseModule in modules){
        [webview addJavascriptObject:baseModule namespace:baseModule.moduleId];
    }
    [webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    // apple bug, compact 之前必须加个 NULL
    [self.webviews addPointer:NULL];
    [self.webviews compact];
    
    [self.webviews addPointer:(__bridge void * _Nullable)(webview)];
    printf("retain count =%ld\n",CFGetRetainCount((__bridge CFTypeRef)([[self.webviews allObjects] firstObject])));


    return webview;
}

/// TODO: 为什么 estimatedProgress 在这??
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


