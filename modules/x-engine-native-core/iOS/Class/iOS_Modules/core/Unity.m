//
//  Unity.m
//  XEngine



#import "Unity.h"
#import <objc/runtime.h>

@implementation Unity

+ (instancetype)sharedInstance
{
    static Unity *__sharedInstance = nil;
    static dispatch_once_t dispatchToken;
    dispatch_once(&dispatchToken, ^{
        __sharedInstance = [[super allocWithZone:NULL] init];
    });
    return __sharedInstance;
}



+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self  sharedInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone{
    return self;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UINavigationController *nav = (UINavigationController *)rootVC;
        currentVC = [self getCurrentVCFrom:[nav topViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}


- (UIView *)topView
{
    UIViewController *vc = [self getCurrentVC];
    UIView *currentView = vc.view;
    return currentView;;
}

@end
