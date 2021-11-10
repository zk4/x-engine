//
//  JSI_direct.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 x-engine. All rights reserved.
//


#import "XENativeContext.h"
#import "JSI_direct.h"
#import "JSIContext.h"
#import "iDirectManager.h"
 

@interface JSI_direct ()
@property (nonatomic, strong)   id<iDirectManager>  directors;
@end
@implementation JSI_direct
JSI_MODULE(JSI_direct)

 
-(void)afterAllJSIModuleInited {
    self.directors = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
}

- (void)_back:(DirectBackDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [self.directors back:dto.scheme host:nil fragment:dto.fragment];
    completionHandler(YES);
  
}

- (void)_push:(DirectPushDTO *)dto complete:(void (^)(BOOL))completionHandler {  
    [self.directors push:dto.scheme host:dto.host pathname:dto.pathname fragment:dto.fragment query:dto.query params:dto.params];
    completionHandler(YES);
}

- (id)_back:(DirectBackDTO *)dto{
     [self.directors back:dto.scheme host:nil fragment:dto.fragment];
    return @"";
}


- (id)_push:(DirectPushDTO *)dto {
    [self.directors push:dto.scheme host:dto.host pathname:dto.pathname fragment:dto.fragment query:dto.query params:dto.params];
    return @"";
}
@end
