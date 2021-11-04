//
//  Native_direct_http_insecure.m
//  direct_http_insecure
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 x-engine. All rights reserved.


#import "Native_direct_http_insecure.h"
#import "XENativeContext.h"
#import "WebViewFactory.h"
#import "Unity.h"
#import "NormalWebViewController.h"
#import "NSURL+QueryDictionary.h"
#import "iDirectManager.h"

@interface Native_direct_http_insecure ()
@property (nonatomic, strong) id<iDirect>  microappDirect;
@end

@implementation Native_direct_http_insecure
NATIVE_MODULE(Native_direct_http_insecure)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_http_insecure";
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



- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params frame:(CGRect)frame {
    return [self.microappDirect getContainer:protocol host:host pathname:pathname fragment:fragment query:query params:params frame:frame];
}
@end
 

 
