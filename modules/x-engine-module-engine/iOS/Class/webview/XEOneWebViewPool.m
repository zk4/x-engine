//
//  WebViewPool.m
//  x-engine-module-engine
//
//  Created by 吕冬剑 on 2020/9/18.
//

#import "XEOneWebViewPool.h"
#import "XEngineWebView.h"
#import "XEngineContext.h"
#import "xengine__module_BaseModule.h"

NSNotificationName const XEWebViewProgressChangeNotification = @"XEWebViewProgressChangeNotification";

@interface XEOneWebViewPool ()

@property (nonatomic, strong) WKProcessPool* wkprocessPool;
@property (nonatomic, strong) NSMutableDictionary<NSString *,XEngineWebView *>* webCacheDic;

@end

@implementation XEOneWebViewPool

+ (instancetype)sharedInstance
{
    static XEOneWebViewPool *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XEOneWebViewPool alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    self = [super init];
    if (self){
        self.wkprocessPool = [[WKProcessPool alloc] init];
        self.webCacheDic = [@{} mutableCopy];
//        self.inSingle = YES;
//        self.inAllSingle = YES;
    }
    return self;
}

-(void)resetUrl:(NSString *)url{
    XEngineWebView *webView = [self getWebView:url];
    if(webView && webView.backForwardList.backList.count > 2){
        [webView goBack];
    }else{
        [webView goToBackForwardListItem:webView.backForwardList.backList.firstObject];
    }
}
    
-(BOOL)checkUrl:(NSString *)url{
    NSString *key = [self urlToDicKey:url];
    return (self.webCacheDic[key] == nil);
}

- (XEngineWebView *)getWebView:(NSString *)url{
    
    NSString *key = [self urlToDicKey:url];
    XEngineWebView *web;
    if(self.inAllSingle){
        web = self.webCacheDic.allValues.firstObject;
    } else {
        web = self.webCacheDic[key];
    }
    if (web == nil){
        web = [self createNewWebView:url];
    }
    if (!self.inAllSingle && !self.inSingle){
        [self.webCacheDic removeObjectForKey:key];
    }
    return web;
}

- (XEngineWebView *)createNewWebView:(NSString *)baseUrl{
    
    if(baseUrl){
        NSString *key = [self urlToDicKey:baseUrl];
        XEngineWebView *web = self.webCacheDic[key];
        if (web == nil){
            web = [self createWebView:baseUrl];
            self.webCacheDic[key] = web;
        }
        return web;
    }
    return nil;
}

-(NSString *)urlToDicKey:(NSString *)url{
    NSString *key = nil;
    if(url){
        NSRange indexRange = [url rangeOfString:@"index.html"];
        if(indexRange.location != NSNotFound){
            key = [url substringToIndex:indexRange.location];
        }
    }
    if(key == nil) {
        key = @"null";
    }
    return key;
}

-(XEngineWebView *)createWebView:(NSString *)baseUrl{
    NSMutableArray *modules = [[XEngineContext sharedInstance] modules];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.processPool = self.wkprocessPool;
    XEngineWebView* webview = [[XEngineWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    webview.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    for (xengine__module_BaseModule *baseModule in modules){
        [webview addJavascriptObject:baseModule namespace:baseModule.moduleId];
    }
    [webview loadUrl:@"about:blank"];
//    [webview loadUrl:baseUrl];
    
    [webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    return webview;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        float floatNum = [[change objectForKey:@"new"] floatValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:XEWebViewProgressChangeNotification object:@(floatNum)];
        if (floatNum >= 1 && (!self.inAllSingle && !self.inSingle)) {
            [object removeObserver:self forKeyPath:@"estimatedProgress"];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
