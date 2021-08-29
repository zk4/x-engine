//
//  RecyleWebViewController.m

#import <WebKit/WebKit.h>
#import "RecyleWebViewController.h"
#import "XEngineWebView.h"
#import "WebViewFactory.h"
#import "XENativeContext.h"
#import "iWebcache.h"


/// TODO: webview refactor
/*
 RecyleWebViewController 只应该接收完整的 url，与 webview。
 由调用者保证 url 正确。不对 url 的处理，打不开就打不开
 RecyleWebViewController 只负责载着 view 做转场动画。
 */

NSString * const OnNativeShow = @"onNativeShow";
NSString * const OnNativeHide = @"onNativeHide";
NSString * const OnNativeDestroyed = @"onNativeDestroyed";


@interface RecyleWebViewController () < WKNavigationDelegate>
@property (nonatomic, copy)   NSString * _Nullable loadUrl;
@property (nonatomic, copy)   NSString *customTitle;
@property (nonatomic, strong) XEngineWebView * _Nullable webview;
@property (nonatomic, assign) Boolean isHiddenNavbar;
@property (nonatomic, assign) Boolean firstDidAppearCbIgnored;
@property (nonatomic, strong) UIProgressView *progresslayer;
@property (nonatomic, strong) UIImageView *imageView404;
@property (nonatomic, strong) UILabel *tipLabel404;
@property (nonatomic, strong) UIView *screenView;
@property (nonatomic, strong) UIImageView *navBarHairlineImageView;
@property (nonatomic, strong) id<iWebcache> webcache;

@end

@implementation RecyleWebViewController

//- (void)handleNavigationTransition:(UIGestureRecognizer *)gap{
//    if (self.webview.canGoBack==YES) {
//        [self.webview goBack];
//    }else{
//        NSLog(@"此时不能左滑");
//    }
//}

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
     
        self.webview= [[WebViewFactory sharedInstance] createWebView];
        self.webview.allowsBackForwardNavigationGestures = YES;
        self.webview.navigationDelegate = self;
        self.webview.frame=frame;

        self.webcache =XENP(iWebcache);
        if(self.webcache){
            [self.webcache enableCache];
        }
        self.isHiddenNavbar = isHidden;
        self.loadUrl = fileUrl;
//        [self.webview loadUrl:self.loadUrl];
//        [self.webview loadFileURL:[NSURL URLWithString:self.loadUrl] allowingReadAccessToURL:[NSURL URLWithString:self.loadUrl]];
//        self.webview.frame = [UIScreen mainScreen].bounds;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewProgressChange:)
                                                     name:@"XEWebViewProgressChangeNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewLoadFail:)
                                                     name:@"XEWebViewLoadFailNotification"
                                                   object:nil];
        [self loadFileUrl];
        
        
        
     
        
    }
    return self;
  
}
-(void) refresh {
    [self.webview reload];
}


- (void)loadFileUrl {
    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]]];
    }else{
//     [self.webview loadFileURL:[NSURL URLWithString:self.loadUrl] allowingReadAccessToURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        [self.webview loadUrl:self.loadUrl];
    }
}

#pragma mark - <callback>
//- (void)goback:(UIButton *)sender {
//    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
//        if(self.navigationController.viewControllers.count > 1){
//            RecyleWebViewController *vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2];
//            if([vc isKindOfClass:[RecyleWebViewController class]]){
//                if(self.webview.backForwardList.backList.count > 0){
//                    WKBackForwardListItem *item = self.webview.backForwardList.backList[self.webview.backForwardList.backList.count - 1];
//                    if([[vc.loadUrl lowercaseString] isEqualToString:[item.URL.absoluteString lowercaseString]] ||
//                       [[NSString stringWithFormat:@"%@#/", [vc.loadUrl lowercaseString]] isEqualToString:[item.URL.absoluteString lowercaseString]]){
//                        [self.navigationController popViewControllerAnimated:YES];
//                        return;
//                    }
//                }
//            }
//        }
//        if([self.webview canGoBack]){
//            // fixme 临时解决一下, webview 自己跳转后, 返回问题
//            WKBackForwardList* list = [self.webview backForwardList];
//            if([self.loadUrl hasPrefix:@"http"] && [[list.backItem.URL absoluteString] isEqual:self.loadUrl]){
//                [self.navigationController popViewControllerAnimated:YES];
//            }else
//                [self.webview goBack];
//        }else{
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

- (void)close:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <life cycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
    [self.webview.scrollView setShowsVerticalScrollIndicator:NO];
    [self.webview.scrollView setShowsHorizontalScrollIndicator:NO];
}

#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(self.firstDidAppearCbIgnored) {
        self.firstDidAppearCbIgnored = NO;
    } else {
        [self.webview triggerVueLifeCycleWithMethod:OnNativeShow];
    }
   
    
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
    
    [self.webcache enableCache];


}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [self.webview triggerVueLifeCycleWithMethod:OnNativeHide];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.webcache disableCache];
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

//- (void)setupBackButton {
//    UIButton *backButton = [[UIButton alloc] init];
//    [backButton setImage: [UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
//    [backButton sizeToFit];
//
//    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
//        NSString *closePath = [[NSBundle mainBundle] pathForResource:@"close_black" ofType:@"png"];
//        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 0)];
//        UIImageView *img2 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:closePath]]];
//        img2.userInteractionEnabled = NO;
//        img2.frame = CGRectMake(4, 6, 22, 22);
//        [closeButton addSubview:img2];
//        [closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItems = @[
//            [[UIBarButtonItem alloc] initWithCustomView:backButton],
//            [[UIBarButtonItem alloc] initWithCustomView:closeButton]
//        ];
//    } else {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    }
//}

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
    XEngineWebView *web = dic[@"webView"];
    if(web == self.webview){
        if(dic[@"progress"]){
            float floatNum = [dic[@"progress"] floatValue];
            self.progresslayer.alpha = 1;
            [self.progresslayer setProgress:floatNum animated:YES];
            if (floatNum == 1) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.progresslayer.alpha = 0;
                }];
      
            }
        }
    }
}

#pragma mark - < utils --> json->dic / dic->json >
/**
 *  JSON字符串转NSDictionary
 *  @param jsonString JSON字符串
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}
/**
 *  字典转JSON字符串
 *  @param dic 字典
 *  @return JSON字符串
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)dealloc {
    [self.webview triggerVueLifeCycleWithMethod:OnNativeDestroyed];
}
@end
