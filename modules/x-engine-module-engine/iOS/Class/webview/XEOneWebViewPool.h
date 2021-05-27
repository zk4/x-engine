//
//  WebViewPool.h
//  x-engine-module-engine
//
//  Created by 吕冬剑 on 2020/9/18.
//

#import <UIKit/UIKit.h>
#import "XEngineWebView.h"

UIKIT_EXTERN NSNotificationName const XEWebViewProgressChangeNotification;
UIKIT_EXTERN NSNotificationName const XEWebViewLoadFailNotification;
@interface XEOneWebViewPool : NSObject

//每个模块是否单个webView
@property (nonatomic, assign) BOOL inSingle;
//所有模块是否单个webView, 为真, 则忽略 inSingle
@property (nonatomic, assign) BOOL inAllSingle;

+ (instancetype)sharedInstance;

- (BOOL)checkUrl:(NSString *)url;
- (XEngineWebView *)getWebView; 
- (XEngineWebView *)createNewWebView:(NSString *)baseUrl;
- (XEngineWebView *)createWebView:(NSString *)baseUrl;
- (void)clearWebView:(NSString *)url;
- (void)webViewChangeTo:(NSString *)url;

@end

