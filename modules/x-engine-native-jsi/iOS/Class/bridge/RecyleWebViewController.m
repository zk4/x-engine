//
//  RecyleWebViewController.m

#import <WebKit/WebKit.h>
#import "RecyleWebViewController.h"
#import "XEngineWebView.h"
#import "WebViewFactory.h"
#import "XENativeContext.h"
#import "iWebcache.h"
#import "iToast.h"
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#define kAppDelegate            ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/// TODO: webview refactor
/*
 RecyleWebViewController 只应该接收完整的 url，与 webview。
 由调用者保证 url 正确。不对 url 的处理，打不开就打不开
 RecyleWebViewController 只负责载着 view 做转场动画。
 */

static NSString * const OnNativeShow = @"onNativeShow";
static NSString * const OnNativeHide = @"onNativeHide";
static NSString * const OnNativeDestroyed = @"onNativeDestroyed";
static NSString * const kWEBVIEW_STATUS_NOT_ON_TOP =@"kWEBVIEW_STATUS_NOT_ON_TOP";
static NSString * const kWEBVIEW_STATUS_ON_TOP  = @"kWEBVIEW_STATUS_ON_TOP";

@interface RecyleWebViewController () < WKNavigationDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, copy)   NSString * _Nullable loadUrl;
@property (nonatomic, copy)   NSString *customTitle;
@property (nonatomic, strong) XEngineWebView * _Nullable webview;
@property (nonatomic, assign) Boolean isHiddenNavbar;
@property (nonatomic, assign) Boolean firstDidAppearCbIgnored;
@property (nonatomic, strong) UIProgressView *progresslayer;
@property (nonatomic, strong) UIImageView *imageView404;
@property (nonatomic, strong) UILabel *tipLabel404;
@property (nonatomic, strong) id<iWebcache> webcache;
@property (nonatomic, assign) BOOL isLooseNetwork;
@property (nonatomic, strong) UIImageView *  imageV;
/** 标记使用状态 */
@property (nonatomic, assign) BOOL bWebviewOnTop;

@property (nonatomic, strong) XEngineWebView * _Nullable preWebview;


@end

@implementation RecyleWebViewController


- (void)webViewLoadFail:(NSNotification *)notifi{
    NSDictionary *dic = notifi.object;
    id web = dic[@"webView"];
    
    if(web == self.webview){
        self.imageView404.hidden = NO;
    }
}
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                withHiddenNavBar:(BOOL)isHidden {
    return [self initWithUrl:fileUrl withHiddenNavBar:isHidden webviewFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame
{
    self = [super init];
    if (self){
        if(fileUrl.length == 0)
            return self;
      
        self.bWebviewOnTop = YES;
        self.webview= [[WebViewFactory sharedInstance] createWebView:NO];
        self.webview.allowsBackForwardNavigationGestures = YES;

        self.webview.scrollView.delegate = self;
        self.webview.frame=frame;
        
    
        self.isHiddenNavbar = isHidden;
        self.loadUrl = fileUrl;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewProgressChange:)
                                                     name:@"XEWebViewProgressChangeNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewLoadFail:)
                                                     name:@"XEWebViewLoadFailNotification"
                                                   object:nil];
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GMJWebViewLoadFinish" object:nil];

        [self loadFileUrl];

        
        [self.webview.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:@"selfClassContextNotSuper"];

    }
    return self;
  
}

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame looseNetwork:(BOOL)isLooseNetwork {
    self = [super init];
    if (self){
        if(fileUrl.length == 0)
            return self;
        self.isLooseNetwork = isLooseNetwork;
        self.webcache =XENP(iWebcache);
        if(!isLooseNetwork) {
            if(self.webcache){
                [self.webcache enableCache];
            }
        }else{
            if(self.webcache)
                [self.webcache disableCache];
        }
        self.bWebviewOnTop = YES;
        self.webview= [[WebViewFactory sharedInstance] createWebView:isLooseNetwork];
        self.webview.allowsBackForwardNavigationGestures = YES;

        self.webview.scrollView.delegate = self;
        self.webview.frame=frame;
    
        self.isHiddenNavbar = isHidden;
        self.loadUrl = fileUrl;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewProgressChange:)
                                                     name:@"XEWebViewProgressChangeNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewLoadFail:)
                                                     name:@"XEWebViewLoadFailNotification"
                                                   object:nil];
        [self loadFileUrl];
        
        
        [self.webview.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:@"selfClassContextNotSuper"];

    }
    return self;
}
- (void)preLoadWebView{
    
}
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame looseNetwork:(BOOL)isLooseNetwork webView:(BOOL )showWebView{
    self = [super init];
    if (self){
        if(fileUrl.length == 0)
            return self;
        self.isLooseNetwork = isLooseNetwork;
        self.webcache =XENP(iWebcache);
        if(!isLooseNetwork) {
            if(self.webcache){
                [self.webcache enableCache];
            }
        }else{
            if(self.webcache)
                [self.webcache disableCache];
        }
        self.bWebviewOnTop = YES;
        if (showWebView) {
            self.webview= [[WebViewFactory sharedInstance] getWebview];
        }else{
            self.webview= [[WebViewFactory sharedInstance] createWebView:isLooseNetwork];
        }
        self.webview.allowsBackForwardNavigationGestures = YES;

        self.webview.scrollView.delegate = self;
        self.webview.frame=frame;
    
        self.isHiddenNavbar = isHidden;
        self.loadUrl = fileUrl;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewProgressChange:)
                                                     name:@"XEWebViewProgressChangeNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewLoadFail:)
                                                     name:@"XEWebViewLoadFailNotification"
                                                   object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewLoadFinish:)
                                                     name:@"GMJWebViewLoadFinish"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewLoadStart:)
                                                     name:@"GMJWebViewLoadStart"
                                                   object:nil];
        

        
        [self loadFileUrl];
        
        
        [self.webview.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:@"selfClassContextNotSuper"];

    }
    return self;
}
- (void)webViewScrollerToTop{
    [self.webview.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webview.scrollView && [keyPath isEqualToString:@"contentOffset"]) {
        CGFloat y = self.webview.scrollView.contentOffset.y;

        if (self.bWebviewOnTop && y>0) {
            self.bWebviewOnTop = false;
            [[NSNotificationCenter defaultCenter] postNotificationName:kWEBVIEW_STATUS_NOT_ON_TOP object:nil userInfo:@{@"webview":self.webview}];
        }
        if(!self.bWebviewOnTop && y==0){
            self.bWebviewOnTop = true;
            [[NSNotificationCenter defaultCenter] postNotificationName:kWEBVIEW_STATUS_ON_TOP object:nil userInfo:@{@"webview":self.webview}];
        }
    }
}

-(void) refresh {
    [self.webview reload];
}


- (void)loadFileUrl {
    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
        [self.webview _loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]]];
    }else{
 
        if([self.loadUrl rangeOfString:[[NSBundle mainBundle] bundlePath]].location != NSNotFound){
            [self.webview loadUrl:self.loadUrl];
        }else{
//             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             NSURL *fileURL = [NSURL URLWithString:self.loadUrl];
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"microapps/.*?/" options:0 error:&error];
            NSTextCheckingResult *match = [regex firstMatchInString:self.loadUrl
                                                            options:0
                                                              range:NSMakeRange(0, [self.loadUrl length])];
            if(error || !match || [match numberOfRanges]==0){
#ifdef DEBUG
                NSString* msg = [NSString stringWithFormat:@"路径不对: %@", self.loadUrl];
                [XENP(iToast) toast: msg];
#endif
                return;
            }
            NSRange matchRange = [match rangeAtIndex:0];
            NSString *safeZone = [self.loadUrl substringWithRange:NSMakeRange(0, matchRange.location+matchRange.length)];
            [self.webview _loadFileURL:fileURL allowingReadAccessToURL:[NSURL URLWithString:safeZone]];
        }
 
    }
}

#pragma mark - <callback>
- (void)close:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <life cycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [button setImage:[UIImage imageNamed:@"appc_back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"appc_back"] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self onCreated];
    
    
    
    [self setUpLoadingView];

}

-(void)setUpLoadingView {
//    self.imageV = [[UIImageView alloc] init];
//    self.imageV.backgroundColor = [UIColor clearColor];
//    self.imageV.layer.masksToBounds = NO;
//    self.imageV.alpha = 0;
//    [self.view addSubview:self.imageV];
//    float height =60;
//
//    self.imageV.frame = CGRectMake((self.view.bounds.size.width - height) * 0.5, (self.view.bounds.size.height - height) * 0.5, height, height);
//    NSString *SuperBgImgPath = [[NSBundle mainBundle] pathForResource:@"111" ofType:@"png"];
//
//     NSURL *APNGURL = [NSURL fileURLWithPath:SuperBgImgPath];
//
//    [self.imageV sd_setImageWithURL:APNGURL];
    UIView *v = [WebViewFactory sharedInstance].customLoadingView;
    if (v) {
        [self.view addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.height.equalTo(@100);
            make.width.equalTo(@100);
        }];
    }


}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self beforeShow];
}

#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self afterShow];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self beforeHide];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self afterHide];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self drawFrame];
}

- (void)drawFrame{
//    self.webview.frame = self.view.bounds;
    self.progresslayer.frame = CGRectMake(0, self.webview.frame.origin.y, self.view.frame.size.width, 1.5);
    float height = (self.view.bounds.size.width / 375.0) * 200;
    self.imageView404.frame = CGRectMake(0, (self.view.bounds.size.height - height) * 0.5, self.view.bounds.size.width, height);
    self.tipLabel404.frame = CGRectMake(0, CGRectGetHeight(self.imageView404.frame) + 8, self.imageView404.bounds.size.width, self.tipLabel404.font.lineHeight);
}
- (XEngineWebView*) getWebView{
    return self.webview;
}
#pragma mark - <ui>
- (void)setupUI {
    self.firstDidAppearCbIgnored = YES;
    self.hidesBottomBarWhenPushed = YES;
    
 
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (@available(iOS 11.0, *)) {
        self.webview.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
     
//    if (@available(iOS 13.0, *)) {
//        self.webview.scrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
//    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.view addSubview:self.webview];
//    [self setupBackButton];
    [self setupProgressLayer];
    [self setup404];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
}


- (void)setupProgressLayer  {
    self.progresslayer = [[UIProgressView alloc] init];
    self.progresslayer.frame = CGRectMake(0, 0, self.view.frame.size.width, 1.5);
    self.progresslayer.progressTintColor = [UIColor orangeColor];
    self.progresslayer.alpha = 0;
    [self.view addSubview:self.progresslayer];
}

- (void)setup404 {
    self.imageView404 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"web404"]];
    self.imageView404.layer.masksToBounds = NO;
    self.imageView404.hidden = YES;
    [self.view addSubview:self.imageView404];
    
    self.tipLabel404 = [[UILabel alloc] init];
    self.tipLabel404.textAlignment = NSTextAlignmentCenter;
    self.tipLabel404.text = @"您访问的页面找不到了。";
    self.tipLabel404.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.tipLabel404.textColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1.0];
    [self.imageView404 addSubview:self.tipLabel404];
}
- (void)webViewLoadFinish:(NSNotification *)notifi{
    
    if ([WebViewFactory sharedInstance].customLoadingView) {
        [WebViewFactory sharedInstance].customLoadingView.alpha = 0;
        [WebViewFactory sharedInstance].customLoadingView.hidden = YES;
    }
  
}
- (void)webViewLoadStart:(NSNotification *)notifi{
    if ([WebViewFactory sharedInstance].customLoadingView) {
        [WebViewFactory sharedInstance].customLoadingView.alpha = 1;
        [WebViewFactory sharedInstance].customLoadingView.hidden = NO;
    }

}


- (void)webViewProgressChange:(NSNotification *)notifi{
    NSDictionary *dic = notifi.object;
    XEngineWebView *web = dic[@"webView"];
    if(web == self.webview){
        if(dic[@"progress"]){
            float floatNum = [dic[@"progress"] floatValue];
            
            if ([WebViewFactory sharedInstance].customLoadingView) {
                //            self.progresslayer.alpha = 1;
                NSLog(@"loading thread %@",[NSThread currentThread]);
                //            [self.progresslayer setProgress:floatNum animated:YES];
                            if (floatNum >=0.85f) {
//                                [UIView animateWithDuration:0.3 animations:^{
                //                    self.progresslayer.alpha = 0;
                                [WebViewFactory sharedInstance].customLoadingView.alpha = 0;
//                                }];
                      
                            }else{
                                [WebViewFactory sharedInstance].customLoadingView.alpha = 1;

                            }
            }else{
                            self.progresslayer.alpha = 1;
//                            self.imageV.alpha = 1;
                            [self.progresslayer setProgress:floatNum animated:YES];
                            if (floatNum == 1) {
                                [UIView animateWithDuration:0.3 animations:^{
                                    self.progresslayer.alpha = 0;
//                                    self.imageV.alpha = 0;
                                }];
                      
                            }
            }

        }
    }
}
 
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XEWebViewProgressChangeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XEWebViewLoadFailNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GMJWebViewLoadFinish" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GMJWebViewLoadStart" object:nil];

    [self beforeDead];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)afterHide {
    
}
- (void)afterShow {
    [self.webview triggerVueLifeCycleWithMethod:OnNativeShow];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    if(!self.isLooseNetwork) {
        if(self.webcache)
            [self.webcache enableCache];
    }else {
        if(self.webcache)
            [self.webcache disableCache];
    }
}

- (void)beforeDead {
    [self.webview triggerVueLifeCycleWithMethod:OnNativeDestroyed];
    [self.webview.scrollView removeObserver:self forKeyPath:@"contentOffset" context:@"selfClassContextNotSuper"];
}

- (void)beforeHide {
    [self.webview triggerVueLifeCycleWithMethod:OnNativeHide];
    if(!self.isLooseNetwork && self.webcache) {
        [self.webcache disableCache];
    }
}

- (void)beforeShow {
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
    [self.webview.scrollView setShowsVerticalScrollIndicator:NO];
    [self.webview.scrollView setShowsHorizontalScrollIndicator:NO];
}

- (void)onCreated {
    [self setupUI];
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

@end
