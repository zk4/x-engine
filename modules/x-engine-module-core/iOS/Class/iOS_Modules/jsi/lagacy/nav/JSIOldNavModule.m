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
    [self.directors back:@"microapp" host:nil path:dto.url];
    if(completionHandler){
        completionHandler(YES);
    }
}

- (void)_navigatorPush:(NavNavigatorDTO *)dto complete:(void (^)(BOOL))completionHandler {

    NSString* scheme = @"microapp";
    [self.directors push:scheme host:nil path:dto.url query:dto.params hideNavbar:dto.hideNavbar];
    if(completionHandler){
        completionHandler(YES);
    }}


-(void)_setNavBarHidden:(NavHiddenBarDTO *)dto complete:(void (^)(BOOL))completionHandler{
    [NavUtil setNavBarHidden:dto.isHidden isAnimation:dto.isAnimation];
    completionHandler(YES);
}


- (void)_setNavTitle:(NavTitleDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [NavUtil setNavTitle:dto.title withTitleColor:dto.titleColor withTitleSize:dto.titleSize];
    completionHandler(YES);
}



@end
