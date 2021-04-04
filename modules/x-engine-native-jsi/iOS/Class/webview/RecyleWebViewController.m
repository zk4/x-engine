//
//  RecyleWebViewController.m

#import "RecyleWebViewController.h"
#import <WebKit/WebKit.h>
#import "XEngineWebView.h"
#import "WebViewFactory.h"
#import "JSIModule.h"
#import "GlobalState.h"
#import "Unity.h"


/*
 RecyleWebViewController 只应该接收完整的 url，与 webview。
 由调用者保证 url 正确。不对 url 的处理，打不开就打不开
 调用者如 nav，router 模块或其他原生模块。
 RecyleWebViewController 只负责载着 view 做转场动画。
 */
@interface RecyleWebViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, copy) NSString * _Nullable loadUrl;

@property (nonatomic, strong) XEngineWebView * _Nullable webview;
@property (nonatomic, assign) Boolean isHiddenNavbar;
@property (nonatomic, strong) UIProgressView *progresslayer;
@property (nonatomic, strong) UIImageView *imageView404;
@property (nonatomic, strong) UILabel *tipLabel404;
@property (nonatomic, copy) NSString *customTitle;
@property (nonatomic, strong) UIView *screenView;
@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@end

@implementation RecyleWebViewController

-(void)webViewProgressChange:(NSNotification *)notifi{
    
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
//                if(![self.webview.URL.absoluteString hasPrefix:@"file:///"]){
//                    [self.webview evaluateJavaScript:@"document.title"
//                                   completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//                        if([response isKindOfClass:[NSString class]]){
//                            NSString *title = response;
//                            title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                            if(title.length > 0){
//                                if(self.title.length == 0){
//                                    self.title = title;
//                                    self.customTitle = self.title;
//                                }
//                            }
//                        }
//                    }];
//                }
            }
        }
//        if(dic[@"title"] && ![dic[@"title"] isKindOfClass:[NSNull class]]){
//            if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
//                self.title = dic[@"title"];
//                self.customTitle = self.title;
//            }
//        }
    }
}

-(void)webViewLoadFail:(NSNotification *)notifi{
    
    NSDictionary *dic = notifi.object;
    id web = dic[@"webView"];
    if(web == self.webview){
        self.imageView404.hidden = NO;
    }
}

- (instancetype _Nonnull )initWithUrl:(NSString * _Nullable)fileUrl host:(NSString * _Nullable)host  fragment:(NSString * _Nullable)fragment webview:(XEngineWebView*)webview withHiddenNavBar:(BOOL)isHidden{
    self = [super init];
    if (self){
        self.isHiddenNavbar = isHidden;
        if(fileUrl.length == 0)
            return self;
        
        self.loadUrl = fileUrl;
        
        self.webview= webview;

        
        HistoryModel* hm = [HistoryModel new];
        hm.vc            = self;
        hm.fragment      = fragment;
        hm.webview       = self.webview;
        hm.host          = host;
        [[GlobalState sharedInstance] addCurrentWebViewHistory:hm];
        
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


- (void)loadFileUrl{
    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]]];
    }else{
        [self.webview loadFileURL:[NSURL URLWithString:self.loadUrl] allowingReadAccessToURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self drawFrame];
}

-(void)drawFrame{
    
    self.webview.frame = self.view.bounds;
    self.progresslayer.frame = CGRectMake(0, self.webview.frame.origin.y, self.view.frame.size.width, 1.5);
    float height = (self.view.bounds.size.width / 375.0) * 200;
    self.imageView404.frame = CGRectMake(0,
                                         (self.view.bounds.size.height - height) * 0.5,
                                         self.view.bounds.size.width,
                                         height);
    
    self.tipLabel404.frame = CGRectMake(0,
                                        CGRectGetHeight(self.imageView404.frame) + 8,
                                        self.imageView404.bounds.size.width,
                                        self.tipLabel404.font.lineHeight);
}

-(void)goback:(UIButton *)sender{
    
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

-(void)close:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        self.webview.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    if (@available(iOS 13.0, *)) {
        self.webview.scrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    UIImage *path = [UIImage imageNamed:@"back_arrow"];
    if(path){
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:path forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
            NSString *closePath = [[NSBundle mainBundle] pathForResource:@"close_black" ofType:@"png"];
            UIButton *close = [[UIButton alloc] init];
            close.frame = CGRectMake(0, 0, 34, 0);
            UIImageView *img2 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:closePath]]];
            img2.userInteractionEnabled = NO;
            img2.frame = CGRectMake(4, 6, 22, 22);
            [close addSubview:img2];
            [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:btn], [[UIBarButtonItem alloc] initWithCustomView:close]];
        }else{
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }
        
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.view addSubview:self.webview];
    
    self.progresslayer = [[UIProgressView alloc] init];
    self.progresslayer.frame = CGRectMake(0, 0, self.view.frame.size.width, 1.5);
    self.progresslayer.progressTintColor = [UIColor orangeColor];
    [self.view addSubview:self.progresslayer];
    
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
    
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
    
}

#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
    
    /// FIXED: 侧滑时，如果并没有滑走，不应该在 viewWillAppear 里 loadFileUrl
//    [self loadFileUrl];

    if(self.screenView){
        //  返回的时候不要急着 remove， 不然会闪历史界面
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.screenView removeFromSuperview];
            self.screenView = nil;
            });
    }
    [self.view insertSubview:self.webview atIndex:0];
    
}
- (void)didMoveToParentViewController:(UIViewController*)parent
{
    [super didMoveToParentViewController:parent];
    if(!parent){
        if([self.webview canGoBack])
            [self.webview goBack];
//        else
//            [self.web pop];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //    [self.webview evaluateJavaScript:@"window.location.href=%@",@"https://www.baidu.com"
    //           completionHandler:nil];

    
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:NO];
    self.progresslayer.alpha = 0;
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.screenView == nil){
        
        self.screenView = [self.view resizableSnapshotViewFromRect:self.view.bounds afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        self.screenView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.screenView];
        self.screenView.frame = self.view.bounds;
    }
}

@end
