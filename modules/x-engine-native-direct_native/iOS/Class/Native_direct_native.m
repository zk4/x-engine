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
    return @"native";
}

- (void)afterAllNativeModuleInited{
}

- (void)back:(NSString*) host fragment:(NSString*) fragment{
    //TODO
}

- (void)push:(NSString*) protocol  // 强制 protocol，非必须
        host:(NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(NSDictionary<NSString*,id>*) query
        params:(NSDictionary<NSString*,id>*) params  {

    //TODO
}


@end
 
