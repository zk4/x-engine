//
//  JSIOldNavModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIOldNavModule.h"
#import "JSIContext.h"
#import "iOpenManager.h"
#import "NativeContext.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "OpenMicroappModule.h"
#import "XEOneWebViewPool.h"
#import "NavUtil.h"
#import "GlobalState.h"
#import "HistoryModel.h"

@interface JSIOldNavModule ()
/*
 webview: (path,vc)
 */

@end

@implementation JSIOldNavModule
JSI_MODULE(JSIOldNavModule)

- (NSString*) moduleId{
    // TODO:
    // should named to com.zkty.jsi.vuerouter
    return @"com.zkty.module.nav";
}




- (void)_navigatorBack:(NavNavigatorBackDTO *)dto complete:(void (^)(BOOL))completionHandler {
    

    UINavigationController* navC=[Unity sharedInstance].getCurrentVC.navigationController;

    NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
    NSMutableArray<HistoryModel*>*  histories=
    [[GlobalState sharedInstance] getCurrentWebViewHistories];

    if ([@"0" isEqualToString:dto.url]){
        for (UIViewController *vc in [ary reverseObjectEnumerator]){
            if (![vc isKindOfClass:[RecyleWebViewController class]]){
                [navC popToViewController:vc animated:YES];
                [histories removeAllObjects];
                return;
            }
        }
      
    }
    else if ([@"/index" isEqualToString:dto.url] || [@"/" isEqualToString:dto.url]){
        if(histories && histories.count > 0){
            [navC popToViewController:histories[0].vc animated:YES];
            [histories removeObjectsInRange:NSMakeRange(1, histories.count - 1)];
        }

    }
    else if ([@"-1" isEqualToString:dto.url] || [@"" isEqualToString:dto.url]){
        if(histories){
            if(histories.count > 1)
            {
            [navC popToViewController:histories[histories.count-2].vc animated:YES];
                [histories removeLastObject];
            }
            else if(histories.count ==1){
                [navC popViewControllerAnimated:YES];
                [histories removeLastObject];
            }
        }

    } else {
        if(histories && histories.count > 1){
            int i = 0;
            for (HistoryModel *hm in [histories reverseObjectEnumerator]){
                if(hm && [hm.path isEqualToString:dto.url]){
                    [navC popToViewController:hm.vc animated:YES];
                    
                    [histories removeObjectsInRange:NSMakeRange(histories.count -i,  i)];
                    return;
                }
                i++;
            }
        }

    }
   
    if(completionHandler){
        completionHandler(YES);
    }
}

- (void)_navigatorPush:(NavNavigatorDTO *)dto complete:(void (^)(BOOL))completionHandler {

    UIViewController * currentVC=[Unity sharedInstance].getCurrentVC;
    RecyleWebViewController* rc= nil;
    if(![currentVC isKindOfClass:RecyleWebViewController.class]){
        // TODO，如果是 tab？ 强制转成 open
        NSLog(@"顶层都不是 RecyleWebViewController，还想着 nav？");
        return;
    }

    rc=(RecyleWebViewController*)currentVC;

    NSString* index=[GlobalState s_microapp_root_url];
    
    // TODO  处理 params
    NSString * finalUrl =[NSString stringWithFormat:@"%@#%@?id=100",index,dto.url];
 
    RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl newWebView:FALSE withHiddenNavBar:dto.hideNavbar];
    
    [currentVC.navigationController pushViewController:vc animated:YES];
    HistoryModel* hm= [HistoryModel new];
    hm.vc = vc;
    hm.path = dto.url;
    [[GlobalState sharedInstance] addCurrentWebViewHistory:hm];
    completionHandler(YES);

}


-(void)_setNavBarHidden:(NavHiddenBarDTO *)dto complete:(void (^)(BOOL))completionHandler{
    [NavUtil setNavBarHidden:dto.isHidden isAnimation:dto.isAnimation];
    completionHandler(YES);
}


- (void)_setNavTitle:(NavTitleDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [NavUtil setNavTitle:dto.title withTitleColor:dto.titleColor withTitleSize:dto.titleSize];
    completionHandler(YES);
}



@end