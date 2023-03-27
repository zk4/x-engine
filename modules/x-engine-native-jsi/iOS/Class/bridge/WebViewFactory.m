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
#import "iToast.h"

@interface WebViewFactory ()<WKScriptMessageHandler>
@property (nonatomic, strong) WKProcessPool* wkprocessPool;
@property (nonatomic, strong) XEngineWebView *preWebView;
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

- (XEngineWebView *)createWebView:(BOOL)isLooseNetwork {
    NSMutableArray *modules = [XENP(iJSIContext) getJSIModules];
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
    webview.scrollView.bounces = false;
    
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
    ///web禁止双击
    {
        NSMutableString *javascript = [NSMutableString string];
        [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd  forMainFrameOnly:YES];
        [webview.configuration.userContentController addUserScript:noneSelectScript];
    }
    
    ///拦截JS  log
//    {
//
//        NSString *jsCode = @"console.log = (function(oriLogFunc){\
//        return function(str)\
//        {\
//        window.webkit.messageHandlers.log.postMessage(str);\
//        oriLogFunc.call(console,str);\
//        }\
//        })(console.log);";
//
//        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:jsCode injectionTime:WKUserScriptInjectionTimeAtDocumentEnd  forMainFrameOnly:YES];
//        [webview.configuration.userContentController addUserScript:noneSelectScript];
//        [webview.configuration.userContentController addScriptMessageHandler:self name:@"log"];
//    }
//
    
    //
    //
    //    NSString*css = @"* { -webkit-user-select: none !important;-moz-user-select: none!important;-webkit-touch-callout: none!important;-webkit-user-drag: none!important;}";
    //    NSMutableString*javascript = [NSMutableString string];
    //    [javascript appendString:@"var style = document.createElement('style');"];
    //    [javascript appendString:@"style.type = 'text/css';"];
    //    [javascript appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    //    [javascript appendString:@"style.appendChild(cssContent);"];
    //    [javascript appendString:@"document.body.appendChild(style);"];
    //
    //    //javascript 注入
    //    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    //    [webview.configuration.userContentController addUserScript:noneSelectScript];
    //
    
    // webcache 插件
    if (!isLooseNetwork) {
        id<iWebcache> webcache= XENP(iWebcache);
        if(webview){
            [webcache enableXHRIntercept:webview];
            [webcache enableFormIntercept:webview];
        }
    }
    
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
//        if (floatNum >= 1) {
//            [object removeObserver:self forKeyPath:@"estimatedProgress"];
//        }
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

- (void)preLoadWithUrl:(NSString *)str{
    self.preWebView = [self createWebView:NO];
    self.preWebView.frame = CGRectMake(0, 0, 1, 1);
    [[UIApplication sharedApplication].keyWindow addSubview:self.preWebView];
    if([[str lowercaseString] hasPrefix:@"http"]){
        [self.preWebView _loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    }else{
        
        if([str rangeOfString:[[NSBundle mainBundle] bundlePath]].location != NSNotFound){
            [self.preWebView loadUrl:str];
        }else{
            //             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSURL *fileURL = [NSURL URLWithString:str];
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"microapps/.*?/" options:0 error:&error];
            NSTextCheckingResult *match = [regex firstMatchInString:str
                                                            options:0
                                                              range:NSMakeRange(0, [str length])];
            if(error || !match || [match numberOfRanges]==0){
#ifdef DEBUG
                NSString* msg = [NSString stringWithFormat:@"路径不对: %@", str];
                [XENP(iToast) toast: msg];
#endif
                return;
            }
            NSRange matchRange = [match rangeAtIndex:0];
            NSString *safeZone = [str substringWithRange:NSMakeRange(0, matchRange.location+matchRange.length)];
            [self.preWebView _loadFileURL:fileURL allowingReadAccessToURL:[NSURL URLWithString:safeZone]];
        }
        
    }
}

- (XEngineWebView *)getWebview{
    return self.preWebView;
}


//- (void)userContentController:(WKUserContentController*)userContentController didReceiveScriptMessage:(WKScriptMessage*)message {
//
//    //    NSLog(@"%@",NSStringFromSelector(_cmd));
//
//    if ([message.name isEqualToString:@"log"]) {
//        NSLog(@"js log*************%@",message.body);
//    }
//
//}
-(void)setCustomLoadingView:(UIView *)customLoadingView {
    if (!_customLoadingView) {
        _customLoadingView = customLoadingView;
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end


