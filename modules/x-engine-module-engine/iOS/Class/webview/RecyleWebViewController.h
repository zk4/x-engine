#import <UIKit/UIKit.h>

@class XEngineWebView;
@interface RecyleWebViewController : UIViewController

@property (nonatomic, copy) NSString *loadUrl;
@property (nonatomic, copy) NSString *preLevelPath;
@property (nonatomic, strong) XEngineWebView * webview;
@property (nonatomic, assign) BOOL isHiddenNavbar;

- (instancetype)initWithUrl:(NSString *)fileUrl;
- (instancetype)initWithUrl:(NSString *)fileUrl withRootPath:(NSString *)rootPath;
- (void)loadFileUrl;

- (void)setSignleWebView:(XEngineWebView *)webView;

- (void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments;
- (void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments completionHandler:(void (^_Nullable)(id  _Nullable value)) completionHandler ;

@end
