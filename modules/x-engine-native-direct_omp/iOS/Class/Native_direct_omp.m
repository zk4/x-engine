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
    NSMutableArray<HistoryModel*>*  histories=
    [[GlobalState sharedInstance] getCurrentWebViewHistories];
    XEngineWebView* webview =[GlobalState getCurrentWebView];
    if(!webview){
        NSLog(@"返回?，webview 都不存在");
    }
    [GlobalState setBackApiCalled:1];

    if ([@"0" isEqualToString:fragment]){
        int i =0;
        for (UIViewController *vc in [ary reverseObjectEnumerator]){
            if (![vc isKindOfClass:[RecyleWebViewController class]]){
                [navC popToViewController:vc animated:YES];
                // 当 i=0 时，也就当前页就不是 RecyleWebViewController，判断现在就是在 tab 页上，不应该清空 histories
                if(i>0)
                    [histories removeAllObjects];
                break;
            }
            i++;
        }
    }
    else if ([@"/" isEqualToString:fragment]){
        if(histories && histories.count > 0){
            // 要与手势区分开来
            // handle webview
            NSArray<WKBackForwardListItem *> * bl = [ [webview backForwardList] backList];
            [webview goToBackForwardListItem:bl.firstObject];

            [navC popToViewController:histories[0].vc animated:YES];
            [histories removeObjectsInRange:NSMakeRange(1, histories.count - 1)];
        }

    }
    else if ([@"-1" isEqualToString:fragment] || [@"" isEqualToString:fragment]){
        if(histories){
            // 要与手势区分开来
            // handle webview
            if([webview canGoBack]){
                [webview goBack];
            }
            
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
        // 处理具体的名字，形如 /abc /bcd
        // TODO: else 应该更加具体，用正则判断
        
        
        if(histories && histories.count > 1){
            unsigned long i = 0;
            for (HistoryModel *hm in [histories reverseObjectEnumerator]){
                if(hm && [hm.fragment isEqualToString:fragment]){
                    i = histories.count - i-1;
                    break;
                }
                i++;
            }
            
            [navC popToViewController:histories[i].vc animated:YES];
            [histories removeObjectsInRange:NSMakeRange(histories.count -i,  i)];

            // 要与手势区分开来
            // handle webview
            WKBackForwardList* wfl= [webview backForwardList];
            NSArray<WKBackForwardListItem *> * bl = [wfl backList];
            WKBackForwardListItem* backtoItem = [bl objectAtIndex:i];
            [webview goToBackForwardListItem:backtoItem];
            
        }

    }
    [GlobalState setBackApiCalled:0];
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
   
        XEngineWebView* webview = [[WebViewFactory sharedInstance] createWebView];
        [GlobalState setCurrentWebView:webview];

       
        BOOL hideNavbar  = [params[@"hideNavbar"] boolValue];
        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl host:host fragment:fragment webview:webview  withHiddenNavBar:hideNavbar];


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
        NSAssert(host!=nil, @"host 不可为 nil");
        NSString * finalUrl = [NSString stringWithFormat:@"%@//%@%@#%@",protocol,host,pathname,fragment];
        
        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalUrl host:host fragment:fragment webview:[GlobalState getCurrentWebView] withHiddenNavBar:[params[@"hideNavbar"] boolValue]];
        
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
