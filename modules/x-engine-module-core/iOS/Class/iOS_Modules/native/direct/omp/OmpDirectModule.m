//
//  OmpDirectModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "OmpDirectModule.h"
#import "NativeContext.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "iDirect.h"
#import "GlobalState.h"
 

@implementation OmpDirectModule
NATIVE_MODULE(OmpDirectModule)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct.omp";
}
- (int) order{
    return 0;
}
 

- (void)back:(NSString*) host path:(NSString*) path{
    UINavigationController* navC=[Unity sharedInstance].getCurrentVC.navigationController;

    NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
    NSMutableArray<HistoryModel*>*  histories=
    [[GlobalState sharedInstance] getCurrentWebViewHistories];

    if ([@"0" isEqualToString:path]){
        for (UIViewController *vc in [ary reverseObjectEnumerator]){
            if (![vc isKindOfClass:[RecyleWebViewController class]]){
                [navC popToViewController:vc animated:YES];
                [histories removeAllObjects];
                return;
            }
        }
    }
    else if ([@"/index" isEqualToString:path] || [@"/" isEqualToString:path]){
        if(histories && histories.count > 0){
            [navC popToViewController:histories[0].vc animated:YES];
            [histories removeObjectsInRange:NSMakeRange(1, histories.count - 1)];
        }

    }
    else if ([@"-1" isEqualToString:path] || [@"" isEqualToString:path]){
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
                if(hm && [hm.path isEqualToString:path]){
                    [navC popToViewController:hm.vc animated:YES];
                    
                    [histories removeObjectsInRange:NSMakeRange(histories.count -i,  i)];
                    return;
                }
                i++;
            }
        }

    }
}

- (void)push:(nonnull NSString *)host path:(nonnull NSString *)path query:(nonnull NSDictionary<NSString *,NSString *> *)query hideNavbar:(BOOL)hideNavbar {
   
//    if(![currentVC isKindOfClass:RecyleWebViewController.class]){
//        // TODO，如果是 tab？ 强制转成 open
//        NSLog(@"顶层都不是 RecyleWebViewController，还想着 nav？");
//        return;
//    }
    UIViewController * currentVC=[Unity sharedInstance].getCurrentVC;

    if(host){
        // TODO 将状态保持到 webview，不要放 GlobalState， GlobalState 不应该存在
        [GlobalState set_s_microapp_root_url:host];
        // TODO 统一一个类处理 URL 地址问题
        NSString * finalUrl = host;
        if(path && ![path isEqualToString:@"/"]){
            finalUrl =[NSString stringWithFormat:@"%@/#%@",host,path];
        }

        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl newWebView:TRUE  withHiddenNavBar:hideNavbar];
        
        HistoryModel* hm= [HistoryModel new];
        hm.vc = vc;
        hm.path = path;
        [[GlobalState sharedInstance] addCurrentWebViewHistory:hm];
       
        
        vc.hidesBottomBarWhenPushed = YES;
        if([Unity sharedInstance].getCurrentVC.navigationController){
            [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];

        } else {
            UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            if([nav isKindOfClass:[UINavigationController class]]){
                [nav pushViewController:vc animated:YES];
            } else {
                nav = nav.navigationController;
                [nav pushViewController:vc animated:YES];
            }
        }
        vc.hidesBottomBarWhenPushed = NO;
        
    }else
    {
        NSString* host=[GlobalState s_microapp_root_url];

        NSString * finalUrl =[NSString stringWithFormat:@"%@/#%@",host,path];
     
        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl newWebView:FALSE withHiddenNavBar:hideNavbar];
        
        [currentVC.navigationController pushViewController:vc animated:YES];
        HistoryModel* hm= [HistoryModel new];
        hm.vc = vc;
        hm.path = path;
        [[GlobalState sharedInstance] addCurrentWebViewHistory:hm];
    }
}

- (nonnull NSString *)scheme {
    return @"omp";
}

@end
