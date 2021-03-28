//
//  H5DirectModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "H5DirectModule.h"
#import "NativeContext.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "HistoryModel.h"
#import "GlobalState.h"
 
 
@implementation H5DirectModule
NATIVE_MODULE(H5DirectModule)


- (NSString*) moduleId{
    return @"com.zkty.native.direct.h5";
}
- (int) order{
    return 0;
}

-(NSString*) scheme{
    return @"h5";
}
//
//  
//- (void)open:(nonnull NSString *)type :(nonnull NSString *)uri :(nonnull NSString *)path :(nonnull NSDictionary *)args :(long)version :(BOOL)isHidden {
//     if(uri){
//         UIViewController *vc =[[RecyleWebViewController alloc] initWithUrl:uri newWebView:TRUE  withHiddenNavBar:isHidden];
//         vc.hidesBottomBarWhenPushed = YES;
//         HistoryModel* hm= [HistoryModel new];
//         hm.vc = vc;
//         hm.path = path;
//         [[GlobalState sharedInstance] addCurrentWebViewHistory:hm];
//        
//         
//         if([Unity sharedInstance].getCurrentVC.navigationController){
//             [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
//
//         } else {
//             UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//             if([nav isKindOfClass:[UINavigationController class]]){
//                 [nav pushViewController:vc animated:YES];
//             } else {
//                 nav = nav.navigationController;
//                 [nav pushViewController:vc animated:YES];
//             }
//         }
//         vc.hidesBottomBarWhenPushed = NO;
//         
//     }
// 
//}
@end
