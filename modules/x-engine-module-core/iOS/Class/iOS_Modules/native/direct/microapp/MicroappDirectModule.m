//
//  MicroappDirectModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "MicroappDirectModule.h"
#import "NativeContext.h"
#import "MicroAppLoader.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "GlobalState.h"

@interface MicroappDirectModule ()
@property (nonatomic, strong) id<iDirect>  microappDirect;
@end
@implementation MicroappDirectModule
NATIVE_MODULE(MicroappDirectModule)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct.microapp";
}
- (int) order{
    return 0;
}

-(NSString*) scheme{
    return @"microapp";
}
- (void)afterAllNativeModuleInited{
   NSArray* modules= [[NativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        // 暂时 与 omp 使用相同的逻辑
        if([[direct scheme] isEqualToString:@"omp"]){
            self.microappDirect = direct;
            return;
        }

    }
}
- (void)back:(NSString*) host path:(NSString*) path{
    [self.microappDirect back:host path:path];
}

- (void)push:(nonnull NSString *)host path:(nonnull NSString *)path query:(nonnull NSDictionary<NSString *,NSString *> *)query hideNavbar:(BOOL)hideNavbar {
    NSString *urlStr = [[MicroAppLoader sharedInstance] getMicroAppUrlStrPathWith:host withVersion:0];
    [GlobalState set_s_microapp_root_url:urlStr];

    [self.microappDirect push:urlStr path:path query:query hideNavbar:hideNavbar];
}
@end
