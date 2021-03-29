//
//  JSIOldNavModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIOldNavModule.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "MicroappDirectModule.h"
#import "XEOneWebViewPool.h"
#import "NavUtil.h"
#import "GlobalState.h"
#import "HistoryModel.h"
#import "iDirectManager.h"

@interface JSIOldNavModule ()
    @property (nonatomic, strong)   id<iDirectManager>  directors;
@end

@implementation JSIOldNavModule
JSI_MODULE(JSIOldNavModule)

- (NSString*) moduleId{
    // TODO:
    // should named to com.zkty.jsi.vuerouter
    return @"com.zkty.module.nav";
}

-(void)afterAllJSIModuleInited {
    self.directors = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
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

//
    NSString* scheme = @"microapp";
    [self.directors push:scheme host:nil path:dto.url query:dto.params hideNavbar:dto.hideNavbar];
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
