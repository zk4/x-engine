#import <UIKit/UIKit.h>
@class XEngineWebView;
@interface RecyleWebViewController : UIViewController

@property (nonatomic, copy) NSString *fileUrl;
@property (nonatomic, copy) NSString *preLevelPath;
@property (nonatomic, strong) XEngineWebView * webview;

- (instancetype)initWithUrl:(NSString *) fileUrl;
- (instancetype)initWithUrl:(NSString *) fileUrl withIsRoot:(BOOL)isRoot;
- (void)loadFileUrl:(NSString *)url;
- (void)forwardUrl:(NSString *)preLevelPath;
- (void)popUrl:(NSString *)preLevelPath;
- (void)popToRoot;
- (void)setSignleWebView:(XEngineWebView *)webView;

- (void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments;
- (void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments completionHandler:(void (^)(id  _Nullable value)) completionHandler ;
@end



