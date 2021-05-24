//
//  Native_direct_native.m
//  direct_native
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_native.h"
#import "XENativeContext.h"

@interface Native_direct_native()
{ }
@property (nonatomic, strong) id<iDirect>  nativeDirect;

@end

@implementation Native_direct_native
NATIVE_MODULE(Native_direct_native)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_native";
}

 

- (int) order{
    return 0;
}
- (nonnull NSString *)protocol {
    return @"file:";
}
-(NSString*) scheme{
    return @"microapp";
}

- (void)afterAllXENativeModuleInited{
   NSArray* modules= [[XENativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        // 暂时 与 omp 使用相同的逻辑
        if([[direct scheme] isEqualToString:[self scheme]]){
            self.nativeDirect = direct;
            return;
        }
    }
}

- (void)back:(NSString*) host fragment:(NSString*) fragment{
    [self.nativeDirect back:host fragment:fragment];
}

- (void)push:(NSString*) protocol  // 强制 protocol，非必须
        host:(NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(NSDictionary<NSString*,id>*) query
        params:(NSDictionary<NSString*,id>*) params  {

    [self.nativeDirect push:[self protocol] host:host pathname:pathname fragment:fragment query:query params:params];
}


@end
 
