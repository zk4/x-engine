//
//  RecyleWebViewController.m

#import "RecyleWebViewController.h"
#import "micros.h"
#import <WebKit/WebKit.h>
#import "XEngineWebView.h"
#import "xengine__module_BaseModule.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewControllerManage.h"

#import "MicroAppLoader.h"
@interface RecyleWebViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, copy) NSString *rootPath;
@property (nonatomic, strong) UIViewController *parentVC;
@property (nonatomic, readwrite) BOOL statusBarHidden;
@property (nonatomic, strong) UIProgressView *progresslayer;
@property (nonatomic, strong) UIImageView *imageView404;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, assign) BOOL isClearHistory;

@property (nonatomic, assign) BOOL isReadyLoading;

@end

@implementation RecyleWebViewController

-(void)webViewProgressChange:(NSNotification *)notifi{
    
    NSDictionary *dic = notifi.object;
    float floatNum = [dic[@"progress"] floatValue];
    id web = dic[@"webView"];
    if(web == self.webview){
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
                            }
                        }
                    }
                }];
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

- (instancetype)initWithUrl:(NSString *) fileUrl{
    return [self initWithUrl:fileUrl withRootPath:fileUrl];
}

- (instancetype)initWithUrl:(NSString *)fileUrl withRootPath:(NSString *)rootPath{
    self = [super init];
    if (self){
        
        if(rootPath.length > 0){
            self.rootPath = rootPath;
        }else{
            NSURLComponents *components = [[NSURLComponents alloc] initWithString:fileUrl];
            if(components.host.length > 0){
                self.rootPath = [NSString stringWithFormat:@"%@://%@", components.scheme, components.host];
            }else{
                self.rootPath = fileUrl;
            }
        }
        self.fileUrl = fileUrl;
        
        if([[XEOneWebViewPool sharedInstance] checkUrl:self.rootPath]
           //           || [fileUrl isEqualToString:self.rootPath]
           || ![XEOneWebViewPool sharedInstance].inSingle){
            
            self.isReadyLoading = YES;
            self.webview = [[XEOneWebViewPool sharedInstance] getWebView:fileUrl];;
            self.webview.configuration.preferences.javaScriptEnabled = YES;
            self.webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
            
            [self.webview.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
            [self.webview.configuration setValue:@YES forKey:@"allowUniversalAccessFromFileURLs"];
            self.webview.frame = [UIScreen mainScreen].bounds;
            if([self.fileUrl hasPrefix:@"http"]){
                [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.fileUrl]]];
            }else{
                if(self.fileUrl.length == 0)
                    return self;
                if([self.fileUrl rangeOfString:[[NSBundle mainBundle] bundlePath]].location != NSNotFound){
                    [self.webview loadFileURL:[NSURL URLWithString:self.fileUrl] allowingReadAccessToURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
                }else{
                    [self.webview loadFileURL:[NSURL URLWithString:self.fileUrl] allowingReadAccessToURL:[NSURL fileURLWithPath:[MicroAppLoader microappDirectory]]];
                }
            }
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewProgressChange:)
                                                     name:XEWebViewProgressChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewLoadFail:)
                                                     name:XEWebViewLoadFailNotification
                                                   object:nil];
        
        if([fileUrl hasPrefix:self.rootPath]){
            
            NSString *interface;
            NSRange range = [fileUrl rangeOfString:@"index.html"];
            if(range.location != NSNotFound && range.location + range.length != fileUrl.length){
                interface = [fileUrl substringFromIndex:range.location + range.length];
                if([interface hasPrefix:@"#"]){
                    interface = [interface substringFromIndex:1];
                }
            }else{
                interface = @"/index";
            }
            range = [interface rangeOfString:@"?"];
            if(range.location != NSNotFound){
                self.preLevelPath = [interface substringToIndex:range.location];
            } else {
                self.preLevelPath = interface;
            }
        }
    }
    return self;
}

-(void)setWebview:(XEngineWebView *)webview{
    _webview = webview;
}

- (void)loadFileUrl:(NSString *)url{
    
    if([self.fileUrl hasPrefix:@"http"]){
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.fileUrl]]];
    }else{
            
        if([self.fileUrl rangeOfString:[[NSBundle mainBundle] bundlePath]].location != NSNotFound){
            [self.webview loadFileURL:[NSURL URLWithString:self.fileUrl] allowingReadAccessToURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        }else{
            [self.webview loadFileURL:[NSURL URLWithString:self.fileUrl] allowingReadAccessToURL:[NSURL fileURLWithPath:[MicroAppLoader microappDirectory]]];
        }
    }
//    if(url){
//        [self.webview stopLoading];
//        if([url hasPrefix:@"http"]){
//            [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//        }else{
//            if([url rangeOfString:[[NSBundle mainBundle] bundlePath]].location != NSNotFound){
//                [self.webview loadFileURL:[NSURL fileURLWithPath:url]
//                  allowingReadAccessToURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//            }else{
//                [self.webview loadFileURL:[NSURL fileURLWithPath:url]
//                  allowingReadAccessToURL:[NSURL fileURLWithPath:[MicroAppLoader microappDirectory]]];
//            }
//        }
//        NSLog(@"%@",self.fileUrl);
//    }
}

- (void)popToRoot{
    if (self.webview.backForwardList.backList.count > 0){
        [self.webview goToBackForwardListItem:self.webview.backForwardList.backList.firstObject];
    }
}

- (void)pop{
    [self.webview goBack];
}

- (void)popUrl:(NSString *)preLevelPath{
    
    if (preLevelPath) {
        NSArray<WKBackForwardListItem *> *backList = self.webview.backForwardList.backList;
        
        if([preLevelPath isEqualToString:@"/index"]){
            if(backList.count > 1){
                [self.webview goToBackForwardListItem:backList.firstObject];
            }
        }else{
            for (NSInteger i = backList.count - 1; i >= 0; i--){
                WKBackForwardListItem *item = backList[i];

                NSString *itemPath = item.URL.absoluteString;

                if([itemPath rangeOfString:preLevelPath].location != NSNotFound){
                    
                    if(i == backList.count - 1){
                        [self.webview goBack];
                    }else{
                        [self.webview goToBackForwardListItem:item];
                    }
                    return;
                }
            }
        }
    } else {
        [self.webview goBack];
    }
}

- (void)forwardUrl:(NSString *)preLevelPath{
    
    if (preLevelPath) {
        NSArray<WKBackForwardListItem *> *backList = self.webview.backForwardList.forwardList;
        for (NSInteger i = backList.count - 1; i >= 0; i--){
            WKBackForwardListItem *item = backList[i];
            NSURLComponents *itemComponents = [NSURLComponents componentsWithURL:item.URL resolvingAgainstBaseURL:YES];
            NSString *itemPath = itemComponents.path;
            NSString *itemFragment = [self framentEmptyAction:itemComponents.fragment];
            
            
            NSURLComponents *finderComponents = [NSURLComponents componentsWithString:preLevelPath];
            NSString *finderPath = finderComponents.path;
            NSString *finderFragment = [self framentEmptyAction:finderComponents.fragment];
            
            if([itemPath isEqualToString:finderPath]
               && [itemFragment isEqualToString:finderFragment]){
                [self.webview goToBackForwardListItem:item];
                return;
            }
        }
    } else {
        [self.webview goBack];
    }
}

-(NSString *)framentEmptyAction:(NSString *)frament{
    NSString *flag;
    if( frament == nil || [frament isEqualToString:@"/"] || [frament isEqualToString:@"null"]){
        flag = @"";
    } else {
        flag = frament;
    }
    return flag;
}

- (void)setSignleWebView:(XEngineWebView *)webView{
    //    if(self.webview != webView){
    [self.webview removeFromSuperview];
    self.webview = webView;
    [self.view addSubview:self.webview];
    [self.view addSubview:self.progresslayer];
    [self.view addSubview:self.imageView404];
    //        [self.view insertSubview:self.webview atIndex:0];
    //    }
}

-(void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments {
    [self runJsFunction:event arguments:arguments completionHandler:nil];
}

-(void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments completionHandler:(void (^)(id  _Nullable value)) completionHandler {
    if(event.length > 0){
        [self.webview callHandler:event arguments:arguments completionHandler:completionHandler];
    }
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.webview.frame = self.view.bounds;
    self.progresslayer.frame = CGRectMake(0, self.webview.frame.origin.y, self.view.frame.size.width, 1.5);
    float height = (self.view.bounds.size.width / 375.0) * 200;
    self.imageView404.frame = CGRectMake(0,
                                         (self.view.bounds.size.height - height) * 0.5,
                                         self.view.bounds.size.width,
                                         height);
    
    self.tipLabel.frame = CGRectMake(0,
                                     CGRectGetHeight(self.imageView404.frame) + 8,
                                     self.imageView404.bounds.size.width,
                                     self.tipLabel.font.lineHeight);
}
-(void)goback:(UIButton *)sender{
    
    if(self.webview.backForwardList.backList.count > 1){
        
        if([XEOneWebViewPool sharedInstance].inSingle && self.navigationController.viewControllers.count >= 2){
            UIViewController *toVc = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2];
            if([toVc isKindOfClass:[RecyleWebViewController class]]){
                RecyleWebViewController *toWebVc = (RecyleWebViewController *)toVc;
                NSString *path = [toWebVc.webview.backForwardList.backList.lastObject.URL absoluteString];
                if([path isEqualToString:toWebVc.fileUrl] || [path isEqualToString:[NSString stringWithFormat:@"%@#/", toWebVc.fileUrl]]){
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
            }
        }
        [self.webview goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"back_arrow" ofType:@"png"];
    if(path){
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 0, 44, 0);
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:path]]];
        img.userInteractionEnabled = NO;
        img.frame = CGRectMake(4, 6, 22, 22);
        [btn addSubview:img];
        [btn addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
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
    
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.text = @"您访问的页面找不到了";
    self.tipLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.tipLabel.textColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1.0];
    [self.imageView404 addSubview:self.tipLabel];
}


#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavbar animated:YES];
    if(self.navigationController.viewControllers.count > 1){
        self.parentVC = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
    }
    self.progresslayer.alpha = 0;
    [[XEOneWebViewControllerManage sharedInstance] createCacheVC];
    [self.view insertSubview:self.webview atIndex:0];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(!self.isCloseClear
       && ![self.parentVC isKindOfClass:[RecyleWebViewController class]]){
        self.isClearHistory = YES;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if(self.navigationController == nil && self.isClearHistory){
        [[XEOneWebViewPool sharedInstance] resetUrl: self.rootPath];
    }
}

- (void)reloadData{
    [self.webview reload];
}

#pragma mark - Full Screen

- (BOOL)statusBarAppearanceByViewController
{
    NSNumber *viewControllerBased = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIViewControllerBasedStatusBarAppearance"];
    if (viewControllerBased && !viewControllerBased.boolValue)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#if RotationObservingForVideoEnabled
- (void)retainStatusBar
{
    if (self.statusBarAppearanceByViewController)
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
}

#pragma mark iOS 8 Prior
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.view layoutSubviews];
    [self retainStatusBar];
}

#pragma mark ios 8 Later
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        [self retainStatusBar];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        //
    }];
}
#endif

- (void)dealloc
{
    
}
@end
