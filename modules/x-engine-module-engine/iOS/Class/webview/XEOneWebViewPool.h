//
//  WebViewPool.h
//  x-engine-module-engine
//
//  Created by 吕冬剑 on 2020/9/18.
//

#import <UIKit/UIKit.h>
#import "XEngineWebView.h"

UIKIT_EXTERN NSNotificationName const XEWebViewProgressChangeNotification;

@interface XEOneWebViewPool : NSObject

//每个模块是否单个webView
@property (nonatomic, assign) BOOL inSingle;
//所有模块是否单个webView, 为真, 则忽略 inSingle
@property (nonatomic, assign) BOOL inAllSingle;

+ (instancetype)sharedInstance;

- (BOOL)checkUrl:(NSString *)url;
- (XEngineWebView *)getWebView:(NSString *)url; 
- (XEngineWebView *)createNewWebView:(NSString *)baseUrl forceCreate:(Boolean)forceCreate;

- (void)resetUrl:(NSString *)url;

@end

