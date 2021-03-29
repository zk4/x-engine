//
//  OpenMicroappModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "OpenH5Module.h"
#import "NativeContext.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "HistoryModel.h"
#import "GlobalState.h"
 
 
@implementation OpenH5Module
NATIVE_MODULE(OpenH5Module)


- (NSString*) moduleId{
    return @"com.zkty.native.open.h5";
}
- (int) order{
    return 0;
}

-(NSString*) type{
    return @"h5";
}

 
- (void)pushWebViewControllerWithUrl:(NSString *)url withIsHiddenNavbar:(BOOL)isHidden{
    
   
}

- (void)open:(nonnull NSString *)type :(nonnull NSString *)uri :(nonnull NSString *)path :(nonnull NSDictionary *)args :(long)version :(BOOL)isHidden {

    NSLog(@"open h5 handled!!");
     if(uri){
        // TODO:
        // ensure url correct
//        if(path.length > 0){
//            urlStr = [NSString stringWithFormat:@"%@%@%@%@", urlStr, ([urlStr hasSuffix:@"index.html"] ? @"#" : @""), ([urlStr hasSuffix:@"/"] || [path hasPrefix:@"/"]) ? @"" : @"/", path];
//        }
        // input correct
        // file://com.zkty.microapp.home
        // https://www.gome.com/index.html
        
         UIViewController *vc =[[RecyleWebViewController alloc] initWithUrl:uri newWebView:TRUE  withHiddenNavBar:isHidden];
         vc.hidesBottomBarWhenPushed = YES;
         HistoryModel* hm= [HistoryModel new];
         hm.vc = vc;
         hm.path = path;
         [[GlobalState sharedInstance] addCurrentWebViewHistory:hm];
        
         
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
         
     }
 
}
@end
