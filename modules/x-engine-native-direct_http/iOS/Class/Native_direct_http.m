//
//  Native_direct_http.m
//  direct_http
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_http.h"
#import "XENativeContext.h"
#import "MicroAppLoader.h"
#import "WebViewFactory.h"
#import "Unity.h"
#import "RecyleWebViewController.h"


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
   NSArray* modules= [[XENativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        // 暂时 与 omp 使用相同的逻辑
        if([[direct scheme] isEqualToString:@"omp"]){
            self.microappDirect = direct;
            return;
        }
    }
}



- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
    return [self.microappDirect getContainer:protocol host:host pathname:pathname fragment:fragment query:query params:params];
}
@end
 
