//
//  Native_direct_omp.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "Native_direct_omp.h"
#import "NativeContext.h"
#import "WebViewFactory.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "iDirect.h"
#import "GlobalState.h"
 
#define  ONE_PAGE_ONE_WEBVIEW TRUE
@implementation Native_direct_omp
NATIVE_MODULE(Native_direct_omp)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_omp";
}
- (int) order{
    return 0;
}
 

- (void)back:(NSString*) host fragment:(NSString*) fragment{
    UINavigationController* navC=[Unity sharedInstance].getCurrentVC.navigationController;

    NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
    NSMutableArray<HistoryModel*>*  histories= nil;
    if(ONE_PAGE_ONE_WEBVIEW){
        histories = [[GlobalState sharedInstance] getCurrentHostHistories];
    }else{
        histories = [[GlobalState sharedInstance] getCurrentWebViewHistories];

    }
    BOOL isMinusHistory = [fragment rangeOfString:@"^-\\d+$" options:NSRegularExpressionSearch].location != NSNotFound;
    
    BOOL isNamedHistory = [fragment rangeOfString:@"^/\\w+$" options:NSRegularExpressionSearch].location != NSNotFound;

    if ([@"0" isEqualToString:fragment]){
        int i =0;
        for (UIViewController *vc in [ary reverseObjectEnumerator]){
            if (![vc isKindOfClass:[RecyleWebViewController class]]){
                [navC popToViewController:vc animated:YES];
                // 当 i=0 时，也就当前页就不是 RecyleWebViewController，判断现在就是在 tab 页上
                if(i>0)
                    [histories removeAllObjects];
                return;
            }
            i++;
        }
    }
    else if ([@"/" isEqualToString:fragment]){
        if(histories && histories.count > 0){
            [navC popToViewController:histories[0].vc animated:YES];
            [histories removeObjectsInRange:NSMakeRange(1, histories.count - 1)];
        }

    }
   
    else if ([@"-1" isEqualToString:fragment] || [@"" isEqualToString:fragment]){
        if(histories){
            if(histories.count > 1)
            {
                /// TODO: 这样解决并不是很优雅. wait for fix
                if(histories[histories.count-2].onTab){
                    [navC popToRootViewControllerAnimated:YES];
                }else{
                    [navC popToViewController:histories[histories.count-2].vc animated:YES];
                }
                [histories removeLastObject];
            }
            else if(histories.count ==1){
                [navC popViewControllerAnimated:YES];
                [histories removeLastObject];
            }
        }

    } else if(isMinusHistory){
        if(histories){
            int minusHistory = [fragment intValue];
            if(minusHistory+histories.count<0){
                /// TODO: alert
                NSLog(@"没有这么历史给你退.");
            }

            [navC popToViewController:histories[histories.count-1+minusHistory].vc animated:YES];
                [histories removeObjectsInRange:NSMakeRange(histories.count+minusHistory,  -minusHistory)];

          
        }
    }
    else if (isNamedHistory){
        if(histories && histories.count > 1){
            int i = 0;
            for (HistoryModel *hm in [histories reverseObjectEnumerator]){
                if(hm && [hm.fragment isEqualToString:fragment]){
                    [navC popToViewController:hm.vc animated:YES];
                    
                    [histories removeObjectsInRange:NSMakeRange(histories.count -i,  i)];
                    return;
                }
                i++;
            }
        }

    }else {
        /// TODO: alert
        NSLog(@"what the fuck? %@",fragment);
    }
}

- (void)push:(NSString*) protocol  // 强制指定 protocol，非必须，
        host:(NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(NSDictionary<NSString*,id>*) query
        params:(NSDictionary<NSString*,id>*) params {
    
    if(!protocol){
        protocol = [self protocol];
    }
    UIViewController * currentVC=[Unity sharedInstance].getCurrentVC;
    
    if(host){
        /// TODO: 统一一个类处理 URL 地址问题
        NSString * finalUrl = [NSString stringWithFormat:@"%@//%@%@#%@",protocol,host,pathname,fragment];

        BOOL hideNavbar  = [params[@"hideNavbar"] boolValue];
        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl host:host fragment:fragment newWebView:TRUE  withHiddenNavBar:hideNavbar];


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
        
    }else{
        NSString* host=[[GlobalState sharedInstance] getLastHost ];
        NSAssert(host!=nil, @"host 不可为 nil");
        NSString * finalUrl = [NSString stringWithFormat:@"%@//%@%@#%@",protocol,host,pathname,fragment];

        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl host:host fragment:fragment newWebView:ONE_PAGE_ONE_WEBVIEW withHiddenNavBar:[params[@"hideNavbar"] boolValue]];
        
        [currentVC.navigationController pushViewController:vc animated:YES];

    }
}

- (nonnull NSString *)scheme {
    return @"omp";
}
- (nonnull NSString *)protocol {
    return @"http:";
}
@end
