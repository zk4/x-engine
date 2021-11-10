//
//  RN_direct.m
//  direct
//
// Copyright (c) 2021 x-engine
// 

#import "RN_direct.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iDirectManager.h"

@interface RN_direct()
//@property (nonatomic, strong)   id<iDirectManager>  directorManager;
@end

@implementation RN_direct

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(pushNative:(NSString *)viewController) {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *vcName = [NSString stringWithFormat:@"%@", viewController];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [[self getCurrentVC].navigationController pushViewController:vc animated:YES];
    });
}

RCT_EXPORT_METHOD(pushMicroapp:(NSString *)microapp) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav setHidesBottomBarWhenPushed:YES];
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor orangeColor];
        [nav pushViewController:vc animated:YES];
    });
}

RCT_EXPORT_METHOD(pushHttp:(NSString *)http) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav setHidesBottomBarWhenPushed:YES];
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor orangeColor];
        [nav pushViewController:vc animated:YES];
    });
}

RCT_EXPORT_METHOD(backNative) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getCurrentVC].navigationController popToRootViewControllerAnimated:YES];
    });
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
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
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

- (UIViewController *)getActivityViewController:(NSString *)controllerName {
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
        if ([[topVC.class description] isEqualToString:@"UINavigationController"]) {
            UINavigationController *navi = (UINavigationController *)topVC;
            if (navi && navi.viewControllers && navi.viewControllers.count > 0) {
                NSInteger count = navi.viewControllers.count;
                for (NSInteger i=count-1; i>=0; i--) {
                    UIViewController *controller = [navi.viewControllers objectAtIndex:i];
                    if ([[controller.class description] isEqualToString:controllerName]) {
                        return controller;
                    }
                }
            }
        }
    }
    return nil;
}

//JSI_MODULE(RN_direct)
//
//- (void)afterAllJSIModuleInited {
//    self.directorManager = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
//}
//
//// 跳转原生
//- (void)pushNative {}
//
//// 返回原生
//- (void)backNative {}
//
//// 跳转微应用
//- (void)pushMicroapp {}
//
//// 返回微应用
//- (void)backMicroapp {}
//
//// 跳转omp
//- (void)pushOmp {}
//
//// 返回omp
//- (void)backOmp {}

@end
