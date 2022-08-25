//
//  WebViewPool.h
//  x-engine-module-engine
//


 

@class XEngineWebView;
@interface WebViewFactory: NSObject
@property (nonatomic, strong) NSPointerArray* webviews;
@property (nonatomic,strong) UIView *customLoadingView;
    + (instancetype)sharedInstance;
    -(XEngineWebView *)createWebView;
- (XEngineWebView *)createWebView:(BOOL)isLooseNetwork;

- (void)preLoadWithUrl:(NSString *)str;

- (XEngineWebView *)getWebview;

@end




