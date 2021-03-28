//
//  OpenOmpModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "OpenOmpModule.h"
#import "NativeContext.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "iOpen.h"
#import "GlobalState.h"
 

@implementation OpenOmpModule
NATIVE_MODULE(OpenOmpModule)

 - (NSString*) moduleId{
    return @"com.zkty.native.open.omp";
}
- (int) order{
    return 0;
}

-(NSString*) type{
    return @"omp";
}
 
 
- (void)open:(nonnull NSString *)type :(nonnull NSString *)uri :(nonnull NSString *)path :(nonnull NSDictionary *)args :(long)version :(BOOL)isHidden {

    NSLog(@"open omp handled!!");
//    s_microapp_root_url = uri;
    [GlobalState set_s_microapp_root_url:uri];

    if(uri){
        // input correct
        // file://com.zkty.microapp.home
        // https://www.gome.com/index.html
        
        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:uri newWebView:TRUE  withHiddenNavBar:isHidden];
        
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
        vc.hidesBottomBarWhenPushed = NO;    }
 
}


@end
