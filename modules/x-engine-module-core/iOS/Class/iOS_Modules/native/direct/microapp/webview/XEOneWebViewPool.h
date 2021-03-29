//
//  WebViewPool.h
//  x-engine-module-engine
//
//  Created by 吕冬剑 on 2020/9/18.
//

#import <UIKit/UIKit.h>
#import "XEngineWebView.h"
#import "XEOneWebViewPoolModel.h"


@interface XEOneWebViewPool: NSObject
    + (instancetype)sharedInstance;
    -(XEOneWebViewPoolModel *)createWebView:(NSString *)baseUrl;
    - (XEngineWebView *)getWebView;
    - (XEOneWebViewPoolModel *)getModelWithWeb:(WKWebView *)webView;
    - (void) bindingAllJSI:(WKWebView*) webview;
@end




