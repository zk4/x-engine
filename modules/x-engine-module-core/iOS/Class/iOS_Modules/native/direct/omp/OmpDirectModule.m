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
 

- (void)back:(NSString*) host pathname:(NSString*) pathname{
    UINavigationController* navC=[Unity sharedInstance].getCurrentVC.navigationController;

    NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
    NSMutableArray<HistoryModel*>*  histories=
    [[GlobalState sharedInstance] getCurrentWebViewHistories];

    if ([@"0" isEqualToString:pathname]){
        for (UIViewController *vc in [ary reverseObjectEnumerator]){
            if (![vc isKindOfClass:[RecyleWebViewController class]]){
                [navC popToViewController:vc animated:YES];
                [histories removeAllObjects];
                return;
            }
        }
    }
    else if ([@"/index" isEqualToString:pathname] || [@"/" isEqualToString:pathname]){
        if(histories && histories.count > 0){
            [navC popToViewController:histories[0].vc animated:YES];
            [histories removeObjectsInRange:NSMakeRange(1, histories.count - 1)];
        }

    }
    else if ([@"-1" isEqualToString:pathname] || [@"" isEqualToString:pathname]){
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
                if(hm && [hm.pathname isEqualToString:pathname]){
                    [navC popToViewController:hm.vc animated:YES];
                    
                    [histories removeObjectsInRange:NSMakeRange(histories.count -i,  i)];
                    return;
                }
                i++;
            }
        }

    }
}

- (void)push:(nonnull NSString *)host pathname:(nonnull NSString *)pathname query:(nonnull NSDictionary<NSString *,NSString *> *)query hideNavbar:(BOOL)hideNavbar {
   
//    if(![currentVC isKindOfClass:RecyleWebViewController.class]){
//        // TODO，如果是 tab？ 强制转成 open
//        NSLog(@"顶层都不是 RecyleWebViewController，还想着 nav？");
//        return;
//    }
    UIViewController * currentVC=[Unity sharedInstance].getCurrentVC;
    
    if(host){
        // 创建 webview 逻辑
        
        // TODO 统一一个类处理 URL 地址问题
        NSString * finalUrl = host;
        if(pathname && ![pathname isEqualToString:@"/"]){
            finalUrl =[NSString stringWithFormat:@"%@#%@",host,pathname];
        }

        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl host:host pathname:pathname newWebView:TRUE  withHiddenNavBar:hideNavbar];


        vc.hidesBottomBarWhenPushed = YES;
        if([Unity sharedInstance].getCurrentVC.navigationController){
            [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];

        } else {
            // webview 内部跳转逻辑
            UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            if([nav isKindOfClass:[UINavigationController class]]){
                [nav pushViewController:vc animated:YES];
            } else {
                nav = nav.navigationController;
                [nav pushViewController:vc animated:YES];
            }
        }
        vc.hidesBottomBarWhenPushed = NO;
        
    }else{
        NSString* host=[[GlobalState sharedInstance] getLastHost ];

        NSString * finalUrl =[NSString stringWithFormat:@"%@#%@",host,pathname];
     
        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl host:host pathname:pathname newWebView:FALSE withHiddenNavBar:hideNavbar];
        
        [currentVC.navigationController pushViewController:vc animated:YES];

    }
}

- (nonnull NSString *)scheme {
    return @"omp";
}

@end
