//
//  Native_direct_https.m
//  direct_https
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_https.h"
#import "XENativeContext.h"
#import "WebViewFactory.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
 

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
 


- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params frame:(CGRect) frame{
    return [self.microappDirect getContainer:protocol host:host pathname:pathname fragment:fragment query:query params:params frame:frame];
}

@end
 
