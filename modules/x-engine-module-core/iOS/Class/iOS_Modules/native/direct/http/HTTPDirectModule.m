//
//  HTTPDirectModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "HTTPDirectModule.h"
#import "NativeContext.h"
#import "MicroAppLoader.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "GlobalState.h"

@interface HTTPDirectModule ()
@property (nonatomic, strong) id<iDirect>  microappDirect;
@end
@implementation HTTPDirectModule
NATIVE_MODULE(HTTPDirectModule)

- (NSString*) moduleId{
    return @"com.zkty.native.direct.http";
}

- (int) order{
    return 0;
}
- (nonnull NSString *)protocol {
    return @"http:";
}
-(NSString*) scheme{
    return @"http";
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

- (void)back:(NSString*) host pathname:(NSString*) pathname{
    [self.microappDirect back:host pathname:pathname];
}

- (void)push:(NSString*) protocol  // 强制 protocol，非必须
        host:(NSString*) host
        pathname:(NSString*) pathname
        query:(NSDictionary<NSString*,NSString*>*) query
        params:(NSDictionary<NSString*,NSString*>*) params {
     [self.microappDirect push:[self protocol] host:host pathname:pathname query:query params:params];
}

@end
