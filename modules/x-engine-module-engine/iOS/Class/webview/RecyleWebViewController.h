#import <UIKit/UIKit.h>

@class XEngineWebView;
@interface RecyleWebViewController : UIViewController

@property (nonatomic, copy) NSString *fileUrl;
@property (nonatomic, copy) NSString *preLevelPath;
@property (nonatomic, strong) XEngineWebView * webview;
//@property (nonatomic, assign) BOOL isCloseClear;
@property (nonatomic, assign) BOOL isHiddenNavbar;

- (instancetype)initWithUrl:(NSString *)fileUrl;
- (instancetype)initWithUrl:(NSString *)fileUrl withRootPath:(NSString *)rootPath;
- (void)loadFileUrl:(NSString *)url;
- (void)forwardUrl:(NSString *)preLevelPath;
- (void)pop;
- (void)popUrl:(NSString *)preLevelPath;
//- (void)popToRoot;
- (void)setSignleWebView:(XEngineWebView *)webView;

- (void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments;
- (void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments completionHandler:(void (^)(id  _Nullable value)) completionHandler ;

@end
