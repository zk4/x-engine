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
@property (nonatomic, strong) NSMutableArray<XEngineWebView *>* webCacheAry;

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
        self.webCacheAry = [@[] mutableCopy];
        self.inSingle = YES;
//        self.inAllSingle = YES;
    }
    return self;
}

    
-(BOOL)checkUrl:(NSString *)url{
    
    XEngineWebView *web = self.webCacheAry.lastObject;
    if(web.superview == nil){
        return YES;
    }
    return NO;
}

- (void)clearWebView:(NSString *)url{
    
    XEngineWebView *web = self.webCacheAry.lastObject;
    if(web){
        if(url){
            if([[web.URL.absoluteString lowercaseString] isEqualToString:[url lowercaseString]] ||
               [[web.URL.absoluteString lowercaseString] isEqualToString:[NSString stringWithFormat:@"%@#/", [url lowercaseString]]] ){
                
                if([web canGoBack]){
                    [web goBack];
                }else{
                    [web loadUrl:@""];
        //            if([AVAudioSession sharedInstance].secondaryAudioShouldBeSilencedHint){
        //                [[AVAudioSession sharedInstance] setActive:YES error:nil];
        //            }
                    [self.webCacheAry removeLastObject];
                    [web removeFromSuperview];
                    web = nil;
                }
                return;
            }
            NSArray<WKBackForwardListItem *> *ary = web.backForwardList.backList;
            if(ary.count > 0){
                NSArray<WKBackForwardListItem *> *reversAry = [[ary reverseObjectEnumerator] allObjects];
                for (int i = 0; i < reversAry.count; i++) {
                    WKBackForwardListItem *item = reversAry[i];
                    if([[item.URL.absoluteString lowercaseString] isEqualToString:[url lowercaseString]]
                       || [item.URL.absoluteString isEqualToString:[NSString stringWithFormat:@"%@#/", url]]){
                        if(i > 0){
                            [web goToBackForwardListItem:reversAry[i - 1]];
                        }else{
                            [web loadUrl:@""];
                            [self.webCacheAry removeLastObject];
                            [web removeFromSuperview];
                            web = nil;
                        }
                        return;
                    }
                }
            }else{
                [web loadUrl:@""];
                [self.webCacheAry removeLastObject];
                [web removeFromSuperview];
            }
        }else{
            [web loadUrl:@""];
            [self.webCacheAry removeLastObject];
            [web removeFromSuperview];
            web = nil;
        }
    }
}


- (void)webViewChangeTo:(NSString *)url{
    
    NSArray *webAry = [[self.webCacheAry reverseObjectEnumerator] allObjects];
    for (XEngineWebView *item in webAry) {
        
        if([[item.URL.absoluteString lowercaseString] isEqualToString:[url lowercaseString]]
           || [item.URL.absoluteString isEqualToString:[NSString stringWithFormat:@"%@#/", url]]){
            return;
        }else{
            WKWebView *web = item;
            NSArray<WKBackForwardListItem *> *ary = web.backForwardList.backList;
            if(ary.count > 0){
                NSArray<WKBackForwardListItem *> *reversAry = [[ary reverseObjectEnumerator] allObjects];
                for (WKBackForwardListItem *item in reversAry) {
                    
                    if([[item.URL.absoluteString lowercaseString] isEqualToString:[url lowercaseString]]
                       || [item.URL.absoluteString isEqualToString:[NSString stringWithFormat:@"%@#/", url]]){
                        
                        [web goToBackForwardListItem:item];
                        return;
                    }
                }
            }
        }
        
        [item loadUrl:@""];
        [self.webCacheAry removeLastObject];
        [item removeFromSuperview];
    }
}

- (XEngineWebView *)getWebView{
    
    XEngineWebView *web = self.webCacheAry.lastObject;
    return web;
}

- (XEngineWebView *)createNewWebView:(NSString *)baseUrl{
    
    if(baseUrl){
        XEngineWebView *web = [self createWebView:baseUrl];
        [self.webCacheAry addObject:web];
        return web;
    }
    return nil;
}

-(NSString *)urlToDicKey:(NSString *)url{

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
//    [webview loadUrl:@"about:blank"];
    [webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
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
    } else if ([keyPath isEqualToString:@"title"]) {
        if([change objectForKey:@"new"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:XEWebViewProgressChangeNotification object:@{
                @"title":[change objectForKey:@"new"],
                @"webView":object,
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
