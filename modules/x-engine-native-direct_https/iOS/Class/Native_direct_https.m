//
//  Native_direct_https.m
//  direct_https
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_https.h"
#import "XENativeContext.h"
#import "MicroAppLoader.h"
#import "WebViewFactory.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "GlobalState.h"

@interface Native_direct_https ()
@property (nonatomic, strong) id<iDirect>  microappDirect;
@end

@implementation Native_direct_https
NATIVE_MODULE(Native_direct_https)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_https";
}
- (nonnull NSString *)protocol {
    return @"https:";
}
-(NSString*) scheme{
    return @"https";
}
- (int) order{
    return 0;
}
- (void)afterAllNativeModuleInited{
   NSArray* modules= [[XENativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        // 暂时 与 omp 使用相同的逻辑
        if([[direct scheme] isEqualToString:@"omp"]){
            self.microappDirect = direct;
            return;
        }
    }
}

- (void)back:(NSString*) host fragment:(NSString*) fragment{
    [self.microappDirect back:host fragment:fragment];
}

- (void)push:(NSString*) protocol  // 强制 protocol，非必须
        host:(NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(NSDictionary<NSString*,id>*) query
        params:(NSDictionary<NSString*,id>*) params
{
    [self.microappDirect push:[self protocol] host:host pathname:pathname fragment:fragment  query:query params:params];
}

@end
 
