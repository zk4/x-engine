//
//  OutWebViewController.m
//  Appc
//
//  Created by 段冲冲 on 2022/6/16.
//

#import "OutWebViewController.h"
#import "iWebcache.h"

#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define IS_IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define IPHONEX_BOTTOM_HEIGHT (IS_IPHONE_X?34.0:0)
#define kTABBAR_HEIGHT (IS_IPHONE_X?83.0:49.0)
#define kStatusHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kNavBarHeight (kStatusHeight + 44.0)

@interface OutWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler,UIGestureRecognizerDelegate>

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) BOOL isHiddenNavbar;
@property (nonatomic, strong) id<iWebcache> webcache;
@property (nonatomic, assign) BOOL isLooseNetwork;


@end

@implementation OutWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatAllSubviews];
}

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame looseNetwork:(BOOL)isLooseNetwork{
    self = [super init];
    if (self){
        self.isLooseNetwork = isLooseNetwork;
        self.isHiddenNavbar = isHidden;
        if(fileUrl.length == 0)
            return self;
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        // CoderMikeHe Fixed : 自适应屏幕宽度js
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        NSString *jsString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width',  initial-scale=1,user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        // 添加自适应屏幕宽度js调用的方法
        [userContentController addUserScript:userScript];
        /// 赋值userContentController
        configuration.userContentController = userContentController;
        
        CGRect rectF = CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight);
        _webView = [[WKWebView alloc] initWithFrame:rectF];
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
        self.webView = _webView;
        //设置uesrAgent
        [_webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSString *userAgent = result;
            
            if ([userAgent rangeOfString:@"/lohashow/appc"].location != NSNotFound) {
                return ;
            }
            NSString *newUserAgent = [userAgent stringByAppendingString:@"/lohashow/appc"];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent,@"UserAgent", nil];
            [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //不添加以下代码则只是在本地更改UA，网页并未同步更改
            [_webView setValue:newUserAgent forKey:@"applicationNameForUserAgent"];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self->_webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                NSString *userAgent = result;
                
                if ([userAgent rangeOfString:@"/lohashow/appc"].location != NSNotFound) {
                    return ;
                }
            }];
        });
        
        [self.navigationController.navigationBar addSubview:self.progressView];
        if (fileUrl) {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
            [_webView loadRequest:request];
        }
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        [self.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

- (void)creatAllSubviews{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [button setImage:[UIImage imageNamed:@"appc_back"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
   if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
       [self.progressView setAlpha:1.0f];
       [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
       if (self.webView.estimatedProgress  >= 1.0f) {
           [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
               [self.progressView setAlpha:0.0f];
           } completion:^(BOOL finished) {
               [self.progressView setProgress:0.0f animated:YES];
           }];
       }
   }else if ([keyPath isEqual:@"URL"]&& object == self.webView){
       NSLog(@"url == %@",_webView.URL.absoluteString);
       if ([_webView.URL.absoluteString containsString:@"app/id486744917"]) {
           [[UIApplication sharedApplication] openURL:_webView.URL];
       }
   }else if ([keyPath isEqual:@"title"]&& object == self.webView){
       self.title = self.webView.title;
   }else {
       [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
   }
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        CGFloat progressViewW = kScreenWidth;
        CGFloat progressViewH = 3;
        CGFloat progressViewX = 0;
        CGFloat progressViewY = CGRectGetHeight(self.navigationController.navigationBar.frame) - progressViewH + 1;
        
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(progressViewX, progressViewY, progressViewW, progressViewH)];
        progressView.progressTintColor = [UIColor cyanColor];
        progressView.trackTintColor = [UIColor clearColor];
        [self.view addSubview:progressView];
        self.progressView = progressView;
    }
    return _progressView;
}

#pragma mark - WKNavigationDelegate
// 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // 可以在这里做正在加载的提示动画 然后在加载完成代理方法里移除动画
    
}
//开始返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {

}
//成功
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    
}


//失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if([error code] == NSURLErrorCancelled) {
            return ;
        }
        
    //Frame load interrupted
    if ([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102) {
        return;
    }
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    if([error code] == NSURLErrorCancelled) {
            return ;
        }
        
    //Frame load interrupted
    if ([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102) {
        return;
    }
}
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView setNavigationDelegate:nil];
}

#pragma mark ---处理全局右滑返回---
 

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{

    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }

    return self.navigationController.childViewControllers.count == 1 ? NO : YES;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (WKWebView* _Nonnull) getWebView{
    return self.webView;
}

#pragma mark 自定义导航按钮支持侧滑手势处理
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.webView.scrollView setShowsVerticalScrollIndicator:NO];
    [self.webView.scrollView setShowsHorizontalScrollIndicator:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}


@end
