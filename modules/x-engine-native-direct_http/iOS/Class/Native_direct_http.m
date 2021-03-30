//
//  Native_direct_http.m
//  direct_http
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_http.h"
#import "NativeContext.h"
#import "MicroAppLoader.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "GlobalState.h"

@interface Native_direct_http ()
@property (nonatomic, strong) id<iDirect>  microappDirect;
@end

@implementation Native_direct_http
NATIVE_MODULE(Native_direct_http)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_http";
}
- (nonnull NSString *)protocol {
    return @"http:";
}
-(NSString*) scheme{
    return @"http";
}
- (int) order{
    return 0;
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
        query:(NSDictionary<NSString*,id>*) query
        params:(NSDictionary<NSString*,id>*) params
{
     [self.microappDirect push:[self protocol] host:host pathname:pathname query:query params:params];
}

@end
 
