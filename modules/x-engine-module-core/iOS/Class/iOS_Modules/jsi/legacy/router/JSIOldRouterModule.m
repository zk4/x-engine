//
//  JSIVueRouterModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIOldRouterModule.h"
#import "JSIContext.h"
#import "iDirectManager.h"
#import "NativeContext.h"
 
@interface JSIOldRouterModule ()
@property (nonatomic, strong)   id<iDirectManager>  directors;
@end
@implementation JSIOldRouterModule
JSI_MODULE(JSIOldRouterModule)

- (NSString*) moduleId{
    return @"com.zkty.module.router";
}

-(void)afterAllJSIModuleInited {
    self.directors = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
}
- (void) openTargetRouter:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {
    NSString* scheme = dict[@"type"];
    [self.directors push:scheme host:dict[@"uri"] path:dict[@"path"] query:dict[@"query"] hideNavbar:dict[@"hideNavbar"]];

}
@end
