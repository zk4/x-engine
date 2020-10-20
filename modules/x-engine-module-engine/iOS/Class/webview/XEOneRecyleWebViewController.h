#import "RecyleWebViewController.h"
@class XEngineWebView;
@interface XEOneRecyleWebViewController : RecyleWebViewController

//- (instancetype)initWithUrl:(NSString *) fileUrl withIsRoot:(BOOL)isRoot;
- (void)loadFileUrl:(NSString *)url;
- (void)forwardUrl:(NSString *)preLevelPath;
- (void)popUrl:(NSString *)preLevelPath;
- (void)setSignleWebView:(XEngineWebView *)webView;


@end



