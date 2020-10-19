//
//  RecyleWebViewController.m

#import "XEOneRecyleWebViewController.h"
#import "XEOneWebViewPool.h"
#import "micros.h"
#import <WebKit/WebKit.h>
#import "XEngineWebView.h"
//#import "JSONToDictionary.h"
#import "xengine__module_BaseModule.h"

#import "Unity.h"
#import "ZKPushAnimation.h"

@interface XEOneRecyleWebViewController ()

@property (nonatomic, strong) CALayer *progresslayer;

@end

@implementation XEOneRecyleWebViewController


//- (instancetype)initWithUrl:(NSString *) fileUrl withIsRoot:(BOOL)isRoot{
//    self = [super init];
//    if (self){
//        
//        self.fileUrl = fileUrl;
//        if(isRoot || ![XEOneWebViewPool sharedInstance].inSignle){
//            self.webview = [[XEOneWebViewPool sharedInstance] getWebView];
////            [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//            self.webview.frame = self.view.bounds;
//            [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.fileUrl]]];
//        }
//    }
//    return self;
//}

//- (void)loadFileUrl:(NSString *)url{
//    NSURLComponents *components = [NSURLComponents componentsWithString:url];
//    NSRange parmarRange = [components.fragment rangeOfString:@"?"];
//    if(parmarRange.location == NSNotFound){
//        self.preLevelPath = components.fragment;
//    } else{
//        self.preLevelPath = [components.fragment substringToIndex:parmarRange.location];
//    }
////    preLevelPath
//    self.fileUrl = url;
//    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//    NSLog(@"%@",self.fileUrl);
//}

//- (void)popUrl:(NSString *)preLevelPath{
//    
//    if (preLevelPath) {
//        NSArray<WKBackForwardListItem *> *backList = self.webview.backForwardList.backList;
//        for (NSInteger i = backList.count - 1; i >= 0; i--){
//            WKBackForwardListItem *item = backList[i];
////        for (WKBackForwardListItem *item in backList){
//            NSURLComponents *itemComponents = [NSURLComponents componentsWithURL:item.URL resolvingAgainstBaseURL:YES];
//            NSString *itemPath = itemComponents.path;
//            NSString *itemFragment = [self framentEmptyAction:itemComponents.fragment];
//            
//            
//            NSURLComponents *finderComponents = [NSURLComponents componentsWithString:preLevelPath];
//            NSString *finderPath = finderComponents.path;
//            NSString *finderFragment = [self framentEmptyAction:finderComponents.fragment];
//
//            if([itemPath isEqualToString:finderPath]
//               && [itemFragment isEqualToString:finderFragment]){
//                [self.webview goToBackForwardListItem:item];
//                return;
//            }
//        }
//    } else {
//        [self.webview goBack];
//    }
//}


- (void)forwardUrl:(NSString *)preLevelPath{
    
    if (preLevelPath) {
        NSArray<WKBackForwardListItem *> *backList = self.webview.backForwardList.forwardList;
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
    if(webView){
        self.webview = webView;
        [self.webview removeFromSuperview];
    }
    [self.view addSubview:self.webview];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    float safeTop = 0;
    if (@available(iOS 11.0, *)) {
        safeTop = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    }
    self.webview.frame = self.view.bounds;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    if( [Unity sharedInstance].getCurrentVC.navigationController.delegate != [ZKPushAnimation instance] ){
        [[ZKPushAnimation instance] isOpenCustomAnimation:[XEOneWebViewPool sharedInstance].inSingle withNavigationController:[Unity sharedInstance].getCurrentVC.navigationController];
    }
}
@end
