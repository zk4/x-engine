//
//  RecyleWebViewController.m

#import "RecyleWebViewController.h"
#import <WebKit/WebKit.h>
#import "XEngineWebView.h"
#import "WebViewFactory.h"
#import "JSIModule.h"
#import "GlobalState.h"
#import "Unity.h"
#import "iSecurify.h"
#import "NativeContext.h"


/// TODO: webview refactor
/*
 RecyleWebViewController 只应该接收完整的 url，与 webview。
 由调用者保证 url 正确。不对 url 的处理，打不开就打不开
 RecyleWebViewController 只负责载着 view 做转场动画。
 */
@interface RecyleWebViewController () <UIGestureRecognizerDelegate, WKNavigationDelegate>
@property (nonatomic, copy)   NSString * _Nullable loadUrl;
@property (nonatomic, copy)   NSString *customTitle;
@property (nonatomic, strong) XEngineWebView * _Nullable webview;
@property (nonatomic, assign) Boolean isHiddenNavbar;
@property (nonatomic, assign) Boolean newWebview;
@property (nonatomic, assign) Boolean isOnTab;
@property (nonatomic, strong) UIProgressView *progresslayer;
@property (nonatomic, strong) UIImageView *imageView404;
@property (nonatomic, strong) UILabel *tipLabel404;
@property (nonatomic, strong) UIView *screenView;
@property (nonatomic, strong) UIImageView *navBarHairlineImageView;
@end

@implementation RecyleWebViewController
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

- (void)webViewLoadFail:(NSNotification *)notifi{
    NSDictionary *dic = notifi.object;
    id web = dic[@"webView"];
    
    if(web == self.webview){
        self.imageView404.hidden = NO;
    }
}
- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl host:(NSString * _Nullable)host  fragment:(NSString * _Nullable)fragment newWebView:(BOOL)newWebView withHiddenNavBar:(BOOL)isHidden onTab:(BOOL)isOnTab {
    self = [super init];
    if (self){
        if(fileUrl.length == 0)
            return self;
        self.webview.allowsBackForwardNavigationGestures = YES;
        self.webview.navigationDelegate = self;
        self.isHiddenNavbar = isHidden;
        self.newWebview = newWebView;
        self.loadUrl = fileUrl;
        self.isOnTab   = isOnTab;
        
        if(newWebView){
            self.webview = [[WebViewFactory sharedInstance] createWebView];
            [self.webview loadUrl:self.loadUrl];
            self.webview.frame = [UIScreen mainScreen].bounds;
            
         }else {
            self.webview = [[GlobalState sharedInstance] getCurrentWebView];
       }
        
        // 存microapp.json 但是存哪里更合适
        // 最后的url会有什么区别, 有几种方式
#warning: 下面这段放哪里合适  这是个问题

//        NSString *microappPath = [host stringByReplacingOccurrencesOfString:@"index.html" withString:@"microapp.json"];
//        if([[NSFileManager defaultManager] fileExistsAtPath:microappPath]){
//            NSString *jsonString = [NSString stringWithContentsOfFile:microappPath encoding:NSUTF8StringEncoding error:nil];
//            id<iSecurify> securify = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iSecurify)];
//            [securify saveMicroAppJsonWithJson:[self dictionaryWithJsonString:jsonString]];
//        } else {
//            UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"mircoapp.json is not define" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController popViewControllerAnimated:YES];
//            }];
//            [errorAlert addAction:sureAction];
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:errorAlert animated:YES completion:^{}];
//        }
//
        // 如果是在 tab 上,则不受 history 管理.
        // 不然会出现这种情况,如果4 个 tab 上全是微应用.
        // 则会有 4 个永远不会消失的 history.
        HistoryModel* hm = [HistoryModel new];
        hm.vc            = self;
        hm.fragment      = fragment;
        hm.webview       = self.webview;
        hm.host          = host;
        hm.onTab         = isOnTab;
        if(!isOnTab){
            [[GlobalState sharedInstance] addCurrentWebViewHistory:hm];
        }else{
            [[GlobalState sharedInstance] addCurrentTab:hm];
        }
        
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
- (instancetype _Nonnull )initWithUrl:(NSString * _Nullable)fileUrl host:(NSString * _Nullable)host  fragment:(NSString * _Nullable)fragment newWebView:(BOOL)newWebView withHiddenNavBar:(BOOL)isHidden{
    return [self initWithUrl:fileUrl host:host fragment:fragment newWebView:newWebView withHiddenNavBar:isHidden onTab:FALSE];
}

- (void)loadFileUrl {
    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]]];
    }else{
        [self.webview loadFileURL:[NSURL URLWithString:self.loadUrl] allowingReadAccessToURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
}

#pragma mark - <callback>
- (void)goback:(UIButton *)sender {
    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
        if(self.navigationController.viewControllers.count > 1){
            RecyleWebViewController *vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2];
            if([vc isKindOfClass:[RecyleWebViewController class]]){
                if(self.webview.backForwardList.backList.count > 0){
                    WKBackForwardListItem *item = self.webview.backForwardList.backList[self.webview.backForwardList.backList.count - 1];
                    if([[vc.loadUrl lowercaseString] isEqualToString:[item.URL.absoluteString lowercaseString]] ||
                       [[NSString stringWithFormat:@"%@#/", [vc.loadUrl lowercaseString]] isEqualToString:[item.URL.absoluteString lowercaseString]]){
                        [self.navigationController popViewControllerAnimated:YES];
                        return;
                    }
                }
            }
        }
        if([self.webview canGoBack]){
            // fixme 临时解决一下, webview 自己跳转后, 返回问题
            WKBackForwardList* list = [self.webview backForwardList];
            if([self.loadUrl hasPrefix:@"http"] && [[list.backItem.URL absoluteString] isEqual:self.loadUrl]){
                [self.navigationController popViewControllerAnimated:YES];
            }else
                [self.webview goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)close:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <life cycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
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
    [self setupBackButton];
    [self setupProgressLayer];
    [self setup404];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
}

#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(self.isOnTab){
        [[GlobalState sharedInstance] setCurrentTabVC:self];
    }

    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
     if(self.screenView){
        //  返回的时候不要急着 remove， 不然会闪历史界面
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.screenView removeFromSuperview];
            self.screenView = nil;
        });
    }
    [self.view insertSubview:self.webview atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.webview evaluateJavaScript:@"window.location.href=%@",@"https://www.baidu.com"
    //           completionHandler:nil];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
    self.progresslayer.alpha = 0;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(!self.newWebview && self.screenView == nil){
        self.screenView = [self.view resizableSnapshotViewFromRect:self.view.bounds afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        self.screenView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.screenView];
        self.screenView.frame = self.view.bounds;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self drawFrame];
}

- (void)drawFrame{
    self.webview.frame = self.view.bounds;
    self.progresslayer.frame = CGRectMake(0, self.webview.frame.origin.y, self.view.frame.size.width, 1.5);
    float height = (self.view.bounds.size.width / 375.0) * 200;
    self.imageView404.frame = CGRectMake(0, (self.view.bounds.size.height - height) * 0.5, self.view.bounds.size.width, height);
    self.tipLabel404.frame = CGRectMake(0, CGRectGetHeight(self.imageView404.frame) + 8, self.imageView404.bounds.size.width, self.tipLabel404.font.lineHeight);
}

#pragma mark - <ui>
- (void)setupBackButton {
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage: [UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    
    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
        NSString *closePath = [[NSBundle mainBundle] pathForResource:@"close_black" ofType:@"png"];
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 0)];
        UIImageView *img2 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:closePath]]];
        img2.userInteractionEnabled = NO;
        img2.frame = CGRectMake(4, 6, 22, 22);
        [closeButton addSubview:img2];
        [closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItems = @[
            [[UIBarButtonItem alloc] initWithCustomView:backButton],
            [[UIBarButtonItem alloc] initWithCustomView:closeButton]
        ];
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
}

- (void)setupProgressLayer  {
    self.progresslayer = [[UIProgressView alloc] init];
    self.progresslayer.frame = CGRectMake(0, 0, self.view.frame.size.width, 1.5);
    self.progresslayer.progressTintColor = [UIColor orangeColor];
    [self.view addSubview:self.progresslayer];
}

- (void)setup404 {
    self.imageView404 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"web404"]];
    self.imageView404.layer.masksToBounds = NO;
    self.imageView404.hidden = YES;
    [self.view addSubview:self.imageView404];
    
    self.tipLabel404 = [[UILabel alloc] init];
    self.tipLabel404.textAlignment = NSTextAlignmentCenter;
    self.tipLabel404.text = @"您访问的页面找不到了";
    self.tipLabel404.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.tipLabel404.textColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1.0];
    [self.imageView404 addSubview:self.tipLabel404];
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

@end
