//
//  JSIOldNavModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIOldNavModule.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "WebViewFactory.h"
#import "GlobalState.h"
#import "HistoryModel.h"
#import "iDirectManager.h"
#import "iUI.h"


@interface JSIOldNavModule ()
    @property (nonatomic, strong)   id<iDirectManager>  directors;
    @property (nonatomic, strong)   id<iUI>  ui;
    
@end

@implementation JSIOldNavModule
JSI_MODULE(JSIOldNavModule)

- (NSString*) moduleId{

    return @"com.zkty.module.nav";
}

-(void)afterAllJSIModuleInited {
    self.directors = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
    self.ui = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iUI)];
}


- (void)_navigatorBack:(NavNavigatorBackDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [self.directors back:@"microapp" host:nil fragment:dto.url];
    if(completionHandler){
        completionHandler(YES);
    }
}

- (void)_navigatorPush:(NavNavigatorDTO *)dto complete:(void (^)(BOOL))completionHandler {

    NSString* scheme = @"microapp";
    /// TODO: convert dto.params to dictionary
    [self.directors push:scheme host:nil pathname:@"" fragment:dto.url query:nil params:@{@"hideNavbar":[NSNumber numberWithBool:dto.hideNavbar] }];
    if(completionHandler){
        completionHandler(YES);
    }}


-(void)_setNavBarHidden:(NavHiddenBarDTO2 *)dto complete:(void (^)(BOOL))completionHandler{
    [self.ui setNavBarHidden:dto.isHidden isAnimation:dto.isAnimation];
    completionHandler(YES);
}


- (void)_setNavTitle:(NavTitleDTO2 *)dto complete:(void (^)(BOOL))completionHandler {

    [self.ui setNavTitle:dto.title withTitleColor:dto.titleColor withTitleSize:dto.titleSize];
    completionHandler(YES);
}



@end
