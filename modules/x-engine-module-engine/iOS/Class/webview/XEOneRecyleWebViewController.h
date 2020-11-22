#import "RecyleWebViewController.h"

@class XEngineWebView;

@interface XEOneRecyleWebViewController : RecyleWebViewController

- (void)loadFileUrl:(NSString *)url;
- (void)forwardUrl:(NSString *)preLevelPath;
- (void)setSignleWebView:(XEngineWebView *)webView;


@end



