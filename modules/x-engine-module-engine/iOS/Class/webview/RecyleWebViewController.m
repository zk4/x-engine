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

@property (nonatomic, strong) UIViewController *parentVC;
@property (nonatomic, readwrite) BOOL statusBarHidden;
@property (nonatomic, strong) UIProgressView *progresslayer;

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
    return [self initWithUrl:fileUrl withIsRoot:YES];
}

- (instancetype)initWithUrl:(NSString *)fileUrl withIsRoot:(BOOL)isRoot{
    self = [super init];
    if (self){
        
        self.fileUrl = fileUrl;
        if(isRoot || ![XEOneWebViewPool sharedInstance].inSingle){
            self.webview = [[XEOneWebViewPool sharedInstance] getWebView:fileUrl];
            //
            self.webview.frame = self.view.bounds;
            [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.fileUrl]]];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewProgressChange:) name:XEWebViewProgressChangeNotification object:nil];
        }
        self.preLevelPath = fileUrl;
    }
    return self;
}

- (void)loadFileUrl:(NSString *)url{
    if(url){
        NSURLComponents *components = [NSURLComponents componentsWithString:url];
        NSRange parmarRange = [components.fragment rangeOfString:@"?"];
        NSString *levelPath;
        if(parmarRange.location == NSNotFound){
            levelPath = components.fragment;
        } else{
            levelPath = [components.fragment substringToIndex:parmarRange.location];
        }
        if(levelPath){
            self.preLevelPath = levelPath;
        }
        //    preLevelPath
        [self.webview stopLoading];
        self.fileUrl = url;
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        NSLog(@"%@",self.fileUrl);
    }
}

- (void)popToRoot{
    if (self.webview.backForwardList.backList.count > 0){
        [self.webview goToBackForwardListItem:self.webview.backForwardList.backList.firstObject];
    }
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
    self.webview = webView;
    [self.webview removeFromSuperview];
    [self.view addSubview:self.webview];
}

-(void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments {
    [self runJsFunction:event arguments:arguments completionHandler:nil];
}

-(void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments completionHandler:(void (^)(id  _Nullable value)) completionHandler {
    [self.webview callHandler:event arguments:arguments completionHandler:completionHandler];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.webview.frame = self.view.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [self.view addSubview:self.webview];
    
    self.progresslayer.frame = CGRectMake(0, 0, self.view.frame.size.width, 1.5);
    self.progresslayer.progressTintColor = [UIColor orangeColor];
    [self.view addSubview:self.progresslayer];
}

-(UIProgressView *)progresslayer{
    if(_progresslayer == nil){
        _progresslayer = [[UIProgressView alloc] init];
    }
    return _progresslayer;
}

#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if(self.navigationController.viewControllers.count>1){
        
        self.parentVC = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
    }
    [[XEOneWebViewControllerManage sharedInstance] createCacheVC];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
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
@end
