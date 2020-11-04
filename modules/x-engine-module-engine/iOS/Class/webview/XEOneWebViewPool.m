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
#import <MicroAppLoader.h>

#import "Unity.h"
#import "RecyleWebViewController.h"

NSNotificationName const XEWebViewProgressChangeNotification = @"XEWebViewProgressChangeNotification";
NSNotificationName const XEWebViewLoadFailNotification = @"XEWebViewLoadFailNotification";

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
        self.inSingle = YES;
//        self.inAllSingle = YES;
    }
    return self;
}

-(void)resetUrl:(NSString *)url{
    if(self.inSingle || self.inAllSingle){
        XEngineWebView *webView = [self getWebView:url];
        if(webView && webView.backForwardList.backList.count == 1){
                    [webView goBack];
//            [webView goToBackForwardListItem:webView.backForwardList.backList.firstObject];
        }
        if(webView.backForwardList.backList.count == 0){
            [webView removeFromSuperview];
        }
    }
}
    
-(BOOL)checkUrl:(NSString *)url{
    NSString *key = [self urlToDicKey:url];
    if(self.webCacheDic[key] == nil){
        return YES;
    }
    if(self.webCacheDic[key].superview == nil){
        return YES;
    }
    return NO;
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
    
//    NSString *head = @"";
//    for (NSInteger i = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers.count - 1; i >= 0; i--) {
//        UIViewController *vc = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers[i];
//        if(![vc isKindOfClass:[RecyleWebViewController class]]){
//
//            head = [[NSNumber numberWithLongLong:(long long)vc] stringValue];
//            break;
//        }
//    }
//    NSURLComponents *components = [[NSURLComponents alloc] initWithString:url];
//    NSString *ss = [NSString stringWithFormat:@"%@%@://%@", head, components.scheme, components.host];
//    return ss;
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:url];
    if([components.scheme isEqualToString:@"file"]){
        NSString *path = components.path;
        if([components.path hasPrefix:[MicroAppLoader microappDirectory]]){
            path = [components.path substringFromIndex:[MicroAppLoader microappDirectory].length];
            NSArray *ary = [path componentsSeparatedByString:@"/"];
            if(ary.count > 0){
                path = ary[1];
            }
        }else if([components.path hasPrefix:[[NSBundle mainBundle] bundlePath]]){
            path = [components.path substringFromIndex:[[NSBundle mainBundle] bundlePath].length];
            NSArray *ary = [path componentsSeparatedByString:@"/"];
            if(ary.count > 0){
                path = ary[1];
            }
        }
        return path;
    }else{
        NSString *ss = [NSString stringWithFormat:@"%@://%@", components.scheme, components.host];
        return ss;
    }
}

-(XEngineWebView *)createWebView:(NSString *)baseUrl{
    NSMutableArray *modules = [[XEngineContext sharedInstance] modules];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.processPool = self.wkprocessPool;
    XEngineWebView* webview = [[XEngineWebView alloc] initWithFrame:CGRectZero configuration:configuration];
//    webview.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    for (xengine__module_BaseModule *baseModule in modules){
        [webview addJavascriptObject:baseModule namespace:baseModule.moduleId];
    }
    [webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    return webview;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        float floatNum = [[change objectForKey:@"new"] floatValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:XEWebViewProgressChangeNotification object:@{
            @"progress":@(floatNum),
            @"webView":object,
        }];
        if (floatNum >= 1 && (!self.inAllSingle && !self.inSingle)) {
            [object removeObserver:self forKeyPath:@"estimatedProgress"];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
