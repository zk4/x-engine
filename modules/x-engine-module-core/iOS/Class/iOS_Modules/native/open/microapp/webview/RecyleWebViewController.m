//
//  RecyleWebViewController.m

#import "RecyleWebViewController.h"
#import <WebKit/WebKit.h>
#import "XEngineWebView.h"
#import "MicroAppLoader.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "aJSIModule.h"
#import "Unity.h"

static   XEngineWebView* s_webview;

/*
 RecyleWebViewController 只应该接收完整的 url，与 webview。不做任务 url 的处理，打不开就打开。
 由上一层做 url 的处理。如 nav，router 模块或其他原生模块。
 */
@interface RecyleWebViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIProgressView *progresslayer;
@property (nonatomic, strong) UIImageView *imageView404;
@property (nonatomic, strong) UILabel *tipLabel404;

@property (nonatomic, copy) NSString *customTiitle;

@property (nonatomic, strong) UIView *screenView;

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@end

@implementation RecyleWebViewController
+ (XEngineWebView*) webview{
    return s_webview;
}
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
                if(![self.webview.URL.absoluteString hasPrefix:@"file:///"]){
                    [self.webview evaluateJavaScript:@"document.title"
                                   completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                        if([response isKindOfClass:[NSString class]]){
                            NSString *title = response;
                            title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                            if(title.length > 0){
                                if(self.title.length == 0){
                                    self.title = title;
                                    self.customTiitle = self.title;
                                }
                            }
                        }
                    }];
                }
            }
        }
        if(dic[@"title"] && ![dic[@"title"] isKindOfClass:[NSNull class]]){
            if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
                self.title = dic[@"title"];
                self.customTiitle = self.title;
            }
        }
    }
}

-(void)webViewLoadFail:(NSNotification *)notifi{
    
    NSDictionary *dic = notifi.object;
    id web = dic[@"webView"];
    if(web == self.webview){
        self.imageView404.hidden = NO;
    }
}
 
- (instancetype _Nonnull )initWithUrl:(NSString * _Nullable)fileUrl newWebView:(Boolean)newWebView withHiddenNavBar:(BOOL)isHidden{
    self = [super init];
    if (self){
        self.isHiddenNavbar = isHidden;

        if(fileUrl.length == 0)
            return self;
        
        self.loadUrl = fileUrl;
        
        if(newWebView){
            self.webview = [[XEOneWebViewPool sharedInstance] createWebView:fileUrl].webView;
            self.webview.configuration.preferences.javaScriptEnabled = YES;
            self.webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
            
            [self.webview.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
            [self.webview.configuration setValue:@YES forKey:@"allowUniversalAccessFromFileURLs"];
            self.webview.frame = [UIScreen mainScreen].bounds;
            s_webview = self.webview;
        }else{
            self.webview = s_webview;
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

- (NSString *)urlEncodedString:(NSString *)str {
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\|\n ";
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
    return [decodedString stringByAddingPercentEncodingWithAllowedCharacters:set];
}

- (void)loadFileUrl{
    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]]];
    }else{
        
        [self.webview loadFileURL:[NSURL URLWithString:self.loadUrl] allowingReadAccessToURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
  
    }

     
}
//执行JS
-(void)runJsFunction:(NSString *)event arguments:(id)arguments {
    [self runJsFunction:event arguments:arguments completionHandler:nil];
}
 
//执行JS
-(void)runJsFunction:(NSString *)event arguments:(id)arguments completionHandler:(void (^)(id  _Nullable value)) completionHandler {
    if(event.length > 0){
        [s_webview callHandler:event arguments:arguments completionHandler:completionHandler];
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
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:YES];
    
}

#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:YES];

    if(self.screenView){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.screenView removeFromSuperview];
            self.screenView = nil;
        });
    }
    [self.view insertSubview:self.webview atIndex:0];
    
//    self.navBarHairlineImageView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self loadFileUrl];

    if(self.customTiitle.length > 0 && ![self.customTiitle isEqualToString: self.title]){
        self.title = self.customTiitle;
    }
    
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:YES];
    self.progresslayer.alpha = 0;
    

    if([[self.loadUrl lowercaseString] hasPrefix:@"http"]){
        if(self.navigationItem.leftBarButtonItems.count > 0){
            self.navigationItem.leftBarButtonItems.lastObject.title = @"";
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    if(self.navigationController == nil){
        NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
        if(![ary.lastObject isKindOfClass:[RecyleWebViewController class]]){
            [[XEOneWebViewPool sharedInstance] clearWebView:self.loadUrl];
        }
    }
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

- (void)dealloc{
    
}

@end
