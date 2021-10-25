//
//  NormalWebViewController.m

#import <WebKit/WebKit.h>
#import "NormalWebViewController.h"


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

@interface NormalWebViewController () < WKNavigationDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, copy)   NSString * _Nullable loadUrl;
@property (nonatomic, copy)   NSString *customTitle;
@property (nonatomic, strong) WKWebView * _Nullable webview;
@property (nonatomic, assign) Boolean isHiddenNavbar;
@property (nonatomic, assign) Boolean firstDidAppearCbIgnored;
@property (nonatomic, strong) UIProgressView *progresslayer;
@property (nonatomic, strong) UIImageView *imageView404;
@property (nonatomic, strong) UILabel *tipLabel404;
/** 标记使用状态 */
@property (nonatomic, assign) BOOL bWebviewOnTop;

@end

@implementation NormalWebViewController


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
        self.webview= [WKWebView new];
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

- (void) dealloc{
    [self.webview.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) refresh {
    [self.webview reload];
}


- (void)loadFileUrl {
    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]]];
    }
}
 
#pragma mark - <life cycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self onCreated];
  
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self beforeShow];
}

#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self afterShow];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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

- (void)webViewProgressChange:(NSNotification *)notifi{
    NSDictionary *dic = notifi.object;
    
}
 
 
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)afterHide {
 }

- (void)afterShow {
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)beforeDead {
 }

- (void)beforeHide {
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

@end
