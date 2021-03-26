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

//每个模块是否单个webView
@property (nonatomic, assign) BOOL inSingle;
//所有模块是否单个webView, 为真, 则忽略 inSingle
@property (nonatomic, assign) BOOL inAllSingle;

+ (instancetype)sharedInstance;
-(XEOneWebViewPoolModel *)createWebView:(NSString *)baseUrl;
- (long)nowMicroAppVersion;
- (NSString *)nowMicroAppLoadUrl;
-(BOOL)checkUrl:(NSString *)url;
- (XEngineWebView *)getWebView;
- (void)clearWebView:(NSString *)url;
- (void)webViewChangeTo:(NSString *)url;
- (XEOneWebViewPoolModel *)getModelWithWeb:(WKWebView *)webView;
@end




