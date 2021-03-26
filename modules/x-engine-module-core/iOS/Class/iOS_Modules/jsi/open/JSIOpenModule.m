//
//  JSIVueRouterModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIOpenModule.h"
#import "JSIContext.h"
#import "iOpenManager.h"
#import "NativeContext.h"
@interface JSIOpenModule ()
@property (nonatomic, strong)   id<iOpenManager>  openerManger;
@end
@implementation JSIOpenModule
JSI_MODULE(JSIOpenModule)

- (NSString*) moduleId{
    // TODO:
    // should named to com.zkty.jsi.open
    return @"com.zkty.module.router";
}

-(void)afterAllJSIModuleInited {
    self.openerManger = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iOpenManager)];
}
- (void) openTargetRouter:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {
    [self.openerManger  open:dict[@"type"] :dict[@"uri"] :dict[@"path"] :dict[@"dict"] :dict[@"version"] :dict[@"hideNavbar"]];
  }
@end
