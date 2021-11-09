//
//  RecyleWebViewController.m

#import <WebKit/WebKit.h>
#import "ReactNativeViewController.h"
#import "XENativeContext.h"
#import "iWebcache.h"
#import "iToast.h"
#import <React/RCTRootView.h>
#import <React/RCTBridge.h>

@interface ReactNativeViewController () <UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, copy)   NSString * _Nullable loadUrl;
@property (nonatomic, copy)   NSString * _Nullable moduleName;
@property (nonatomic, assign) Boolean isHiddenNavbar;
@end

@implementation ReactNativeViewController

- (instancetype)initWithUrl:(NSString *)fileUrl withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect)frame moduleName:(NSString *)name {
    self = [super init];
    if (self) {
        NSString *url = [NSString stringWithFormat:@"http%@", [fileUrl substringFromIndex:2]];
        RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:[NSURL URLWithString:url] moduleName:name initialProperties:nil launchOptions:nil];
        rootView.frame = frame;
        [self.view addSubview:rootView];
    }
    return self;
}


#pragma mark ---处理全局右滑返回---
// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    return self.navigationController.childViewControllers.count == 1 ? NO : YES;
}
@end
