//
//  JSIUIModule.m
//  ModuleApp
//
//  Created by cwz on 2021/3/30.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIUIModule.h"
#import "JSIContext.h"
#import "iDirectManager.h"
#import "NativeContext.h"
#import "iUI.h"

@interface JSIUIModule ()
@property (nonatomic, strong) id<iUI> ui;
@end

@implementation JSIUIModule

JSI_MODULE(JSIUIModule)

- (NSString*) moduleId{
    return @"com.zkty.jsi.ui";
}

- (void)afterAllJSIModuleInited {
    self.ui = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iUI)];
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
