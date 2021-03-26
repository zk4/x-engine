#import <UIKit/UIKit.h>

@class XEngineWebView;
@interface RecyleWebViewController : UIViewController

@property (nonatomic, copy) NSString * _Nullable loadUrl;
@property (nonatomic, copy) NSString * _Nullable preLevelPath;
@property (nonatomic, strong) XEngineWebView * _Nullable webview;
@property (nonatomic, assign) BOOL isHiddenNavbar;

+ (XEngineWebView * _Nullable) webview;
- (instancetype _Nonnull )initWithUrl:(NSString * _Nullable)fileUrl;
- (instancetype _Nonnull )initWithUrl:(NSString * _Nullable)fileUrl withRootPath:(NSString * _Nullable)rootPath withHiddenNavBar:(BOOL)isHidden;
- (void)loadFileUrl;

- (void)setSignleWebView:(XEngineWebView * _Nullable)webView;

- (void)runJsFunction:(NSString * _Nullable)event arguments:(id _Nullable)arguments;
- (void)runJsFunction:(NSString * _Nullable)event arguments:(id _Nullable)arguments completionHandler:(void (^_Nullable)(id  _Nullable value)) completionHandler ;

@end
