//
//  WebViewPool.h
//  x-engine-module-engine
//


 

@class XEngineWebView;
@interface WebViewFactory: NSObject
@property (nonatomic, strong) NSPointerArray* webviews;
    + (instancetype)sharedInstance;
    -(XEngineWebView *)createWebView;
- (XEngineWebView *)createWebView:(BOOL)isLooseNetwork;

@end




