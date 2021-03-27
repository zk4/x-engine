//
//  OpenMicroappModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "OpenMicroappModule.h"
#import "NativeContext.h"
#import "MicroAppLoader.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "GlobalState.h"

@implementation OpenMicroappModule
NATIVE_MODULE(OpenMicroappModule)

 - (NSString*) moduleId{
    return @"com.zkty.native.open.microapp";
}
- (int) order{
    return 0;
}

-(NSString*) type{
    return @"microapp";
}

  
- (void)open:(nonnull NSString *)type :(nonnull NSString *)uri :(nonnull NSString *)path :(nonnull NSDictionary *)args :(long)version :(BOOL)isHidden {

    NSLog(@"open microapp handled!!");
    
    NSString *urlStr = [[MicroAppLoader sharedInstance] getMicroAppUrlStrPathWith:uri withVersion:version];
    [GlobalState set_s_microapp_root_url:urlStr];
    
    if(urlStr){
        // TODO:
        // ensure url correct
        if(path.length > 0){
            urlStr = [NSString stringWithFormat:@"%@%@%@%@", urlStr, ([urlStr hasSuffix:@"index.html"] ? @"#" : @""), ([urlStr hasSuffix:@"/"] || [path hasPrefix:@"/"]) ? @"" : @"/", path];
        }
        // input correct
        // file://com.zkty.microapp.home
        // https://www.gome.com/index.html
        
        RecyleWebViewController *vc =   [[RecyleWebViewController alloc] initWithUrl:urlStr newWebView:TRUE  withHiddenNavBar:isHidden];;
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
        
    }
 
}
@end
