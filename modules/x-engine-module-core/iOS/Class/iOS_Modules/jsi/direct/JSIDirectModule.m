//
//  JSIDirectModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIDirectModule.h"
#import "JSIContext.h"
#import "iDirectManager.h"
#import "NativeContext.h"
#import "JSIOldNavModule.h"
#import "JSIContext.h"
#import "iDirectManager.h"
#import "NativeContext.h"
#import "Unity.h"
#import "RecyleWebViewController.h"

#import "GlobalState.h"
#import "HistoryModel.h"
#import "NSURL+QueryDictionary.h"
#import "NSString+Router+URLQuery.h"


@interface JSIDirectModule ()
@property (nonatomic, strong)   id<iDirectManager>  directors;
@end
@implementation JSIDirectModule
JSI_MODULE(JSIDirectModule)

 
-(void)afterAllJSIModuleInited {
    self.directors = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
}

- (void)_back:(DirectBackDTO *)dto complete:(void (^)(BOOL))completionHandler {
    completionHandler(YES);
  
}

- (void)_push:(DirectPushDTO *)dto complete:(void (^)(BOOL))completionHandler {  
    [self.directors push:dto.scheme host:dto.host pathname:dto.pathname query:dto.query hideNavbar:dto.hideNavbar];
    completionHandler(YES);
}


@end
