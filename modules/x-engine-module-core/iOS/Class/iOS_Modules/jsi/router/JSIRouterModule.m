//
//  JSIRouterModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIRouterModule.h"
#import "JSIContext.h"
#import "iOpenManager.h"
#import "NativeContext.h"
 
@interface JSIRouterModule ()
@property (nonatomic, strong)   id<iOpenManager>  openerManger;
@end
@implementation JSIRouterModule
JSI_MODULE(JSIRouterModule)

- (NSString*) moduleId{
    return @"com.zkty.jsi.router";
}

-(void)afterAllJSIModuleInited {
    self.openerManger = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iOpenManager)];
}
- (void) openTargetRouter:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {
    [self.openerManger  open:dict[@"type"] :dict[@"uri"] :dict[@"path"] :dict[@"dict"] :dict[@"version"] :dict[@"hideNavbar"]];
  }
@end
