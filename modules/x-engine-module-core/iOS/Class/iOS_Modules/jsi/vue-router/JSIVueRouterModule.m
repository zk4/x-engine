//
//  JSIVueRouterModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIVueRouterModule.h"
#import "JSIContext.h"
#import "iOpenManager.h"
#import "NativeContext.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "OpenMicroappModule.h"
#import "XEOneWebViewPool.h"
#import "NavUtil.h"

@interface JSIVueRouterModule ()

@end
@implementation JSIVueRouterModule
JSI_MODULE(JSIVueRouterModule)
static NSString* preLevelPath;
- (NSString*) moduleId{
    // TODO:
    // should named to com.zkty.jsi.vuerouter
    return @"com.zkty.module.nav";
}



- (void)_navigatorBack:(NavNavigatorBackDTO *)dto complete:(void (^)(BOOL))completionHandler {
    
//    if ([@"0" isEqualToString:dto.url]){
//        [[Unity sharedInstance].getCurrentVC.navigationController popToRootViewControllerAnimated:YES];
//        return;
//    }
    
    BOOL isAction = false;
    NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
    UIViewController *lastVc;
    for (UIViewController *vc in ary) {
        
        if ([vc isKindOfClass:[RecyleWebViewController class]]){
            if ([@"0" isEqualToString:dto.url]){
                if(lastVc == nil){
                    lastVc = vc;
                }
                [[Unity sharedInstance].getCurrentVC.navigationController popToViewController:lastVc animated:YES];
                return;;
            }
            RecyleWebViewController *webVC = (RecyleWebViewController *)vc;
            if (preLevelPath && [preLevelPath isEqualToString:dto.url]){
                [[Unity sharedInstance].getCurrentVC.navigationController popToViewController:webVC animated:YES];
                isAction = YES;
                break;
            }
            else if ([@"/index" isEqualToString:dto.url] && [vc isKindOfClass:[RecyleWebViewController class]]){
                [[Unity sharedInstance].getCurrentVC.navigationController popToViewController:webVC animated:YES];
                isAction = YES;
                break;
            }
        }else{
            lastVc = vc;
        }
    }
    if (!isAction){
//        [[Unity sharedInstance].getCurrentVC pop];
        [[Unity sharedInstance].getCurrentVC.navigationController popViewControllerAnimated:YES];
    }
    if(completionHandler){
        completionHandler(YES);
    }
}

- (void)_navigatorPush:(NavNavigatorDTO *)dto complete:(void (^)(BOOL))completionHandler {
    UIViewController * currentVC=[Unity sharedInstance].getCurrentVC;
    currentVC.hidesBottomBarWhenPushed = YES;
    // TODO
    NSString* index=OpenMicroappModule.s_microapp_root_url;
    NSString * finalUrl =[NSString stringWithFormat:@"%@#%@?id=100",index,dto.url];
    preLevelPath  = dto.url;
    
    RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl newWebView:FALSE withHiddenNavBar:dto.hideNavbar];
    
    [currentVC.navigationController pushViewController:vc animated:YES];

    completionHandler(YES);

}


-(void)_setNavBarHidden:(NavHiddenBarDTO *)dto complete:(void (^)(BOOL))completionHandler{
    
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    [topVC.navigationController setNavigationBarHidden:dto.isHidden animated:dto.isAnimation];
    completionHandler(YES);
}


- (void)_setNavTitle:(NavTitleDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [NavUtil setNavTitle:dto.title withTitleColor:dto.titleColor withTitleSize:dto.titleSize];

    completionHandler(YES);
}



@end
