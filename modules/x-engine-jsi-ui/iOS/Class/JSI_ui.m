//
//  JSI_ui.m
//  ui
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_ui.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iUI.h"

@interface JSI_ui ()
@property (nonatomic, strong) id<iUI> ui;
@end

@implementation JSI_ui
JSI_MODULE(JSI_ui)
  
- (void)afterAllJSIModuleInited {
    self.ui = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iUI)];
}

-(void)_setNavBarHidden:(NavHiddenBarDTO *)dto complete:(void (^)(BOOL))completionHandler{
    [self.ui setNavBarHidden:dto.isHidden isAnimation:dto.isAnimation];
    completionHandler(YES);
}


- (void)_setNavTitle:(NavTitleDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [self.ui setNavTitle:dto.title withTitleColor:dto.titleColor withTitleSize:dto.titleSize];
    completionHandler(YES);
}

@end
 
