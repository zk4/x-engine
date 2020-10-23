//
//  RecyleWebViewController.m

#import "RecyleWebViewController.h"
#import "micros.h"
#import <WebKit/WebKit.h>
#import "XEngineWebView.h"
//#import "JSONToDictionary.h"
#import "xengine__module_BaseModule.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewControllerManage.h"

#import "MicroAppLoader.h"
@interface RecyleWebViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, copy) NSString *rootPath;
@property (nonatomic, strong) UIViewController *parentVC;
@property (nonatomic, readwrite) BOOL statusBarHidden;
@property (nonatomic, strong) UIProgressView *progresslayer;

@property (nonatomic, assign) BOOL isClearHistory;

@property (nonatomic, assign) BOOL isReadyLoading;

@end

@implementation RecyleWebViewController

-(void)webViewProgressChange:(NSNotification *)notifi{
    
        self.progresslayer.alpha = 1;
        float floatNum = [notifi.object floatValue];
        [self.progresslayer setProgress:floatNum animated:YES];
        if (floatNum == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                self.progresslayer.alpha = 0;
            }];
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
            self.rootPath = [NSString stringWithFormat:@"%@://%@", components.scheme, components.host];
        }
        self.fileUrl = fileUrl;
        
        if([[XEOneWebViewPool sharedInstance] checkUrl:self.rootPath]
           || [fileUrl isEqualToString:self.rootPath]
            || ![XEOneWebViewPool sharedInstance].inSingle){
            
            self.isReadyLoading = YES;
            self.webview = [[XEOneWebViewPool sharedInstance] getWebView:self.rootPath];;
            self.webview.frame = [UIScreen mainScreen].bounds;
            [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.fileUrl]]];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(webViewProgressChange:)
                                                     name:XEWebViewProgressChangeNotification
                                                   object:nil];
        if([fileUrl hasPrefix:self.rootPath]){
            
            NSString *interface = [fileUrl substringFromIndex:self.rootPath.length];
            if([interface hasPrefix:@"#"]){
                interface = [interface substringFromIndex:1];
            }
            if([interface hasPrefix:@"/"]){
                interface = [interface substringFromIndex:1];
            }
            NSRange range = [interface rangeOfString:@"?"];
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
    if(!self.isReadyLoading){
        if(url){
            [self.webview stopLoading];
            [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            NSLog(@"%@",self.fileUrl);
        }
    }
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
        for (NSInteger i = backList.count - 1; i >= 0; i--){
            WKBackForwardListItem *item = backList[i];
            //        for (WKBackForwardListItem *item in backList){
            NSURLComponents *itemComponents = [NSURLComponents componentsWithURL:item.URL resolvingAgainstBaseURL:YES];
            NSString *itemPath = itemComponents.path;
            NSString *itemFragment = [self framentEmptyAction:itemComponents.fragment];
            
            
            NSURLComponents *finderComponents = [NSURLComponents componentsWithString:preLevelPath];
            NSString *finderPath = finderComponents.path;
            NSString *finderFragment = [self framentEmptyAction:finderComponents.fragment];
            
            if([itemPath isEqualToString:finderPath]
               && [itemFragment isEqualToString:finderFragment]){
                
                if(i == backList.count - 1){
                    [self.webview goBack];
                }else{
                    [self.webview goToBackForwardListItem:item];
                }
                return;
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
    if(self.webview != webView){
        [self.webview removeFromSuperview];
        self.webview = webView;
//        [self.view addSubview:self.webview];
        [self.view insertSubview:self.webview atIndex:0];
    }
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
}

//-(UIProgressView *)progresslayer{
//    if(_progresslayer == nil){
//        _progresslayer = [[UIProgressView alloc] init];
//    }
//    return _progresslayer;
//}

#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if(self.navigationController.viewControllers.count>1){
        
        self.parentVC = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
    }
    [[XEOneWebViewControllerManage sharedInstance] createCacheVC];
    [self.view insertSubview:self.webview atIndex:0];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(!self.isCloseClear && ![self.navigationController.viewControllers.lastObject isKindOfClass:[RecyleWebViewController class]]){
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
