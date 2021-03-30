//
//  Native_direct_manager.m
//  direct_manager
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_manager.h"
#import "NativeContext.h"
#import "iDirectManager.h"
#import "iDirect.h"
@interface Native_direct_manager()
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iDirect>> * directors;
@end

@implementation Native_direct_manager
NATIVE_MODULE(Native_direct_manager)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_manager";
}

- (int) order{
    return 0;
}

- (instancetype)init
{
    self = [super init];
    self.directors=[NSMutableDictionary new];
    return self;
}

- (void)afterAllNativeModuleInited{
   NSArray* modules= [[NativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        [self.directors setObject:direct forKey:[direct scheme]];
    }
}

- (void)back: (NSString*) scheme host:(NSString*) host pathname:(NSString*) pathname{
    id<iDirect> direct = [self.directors objectForKey:scheme];
    [direct back:host pathname:pathname];
}

- (void)push: (NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        query:(nullable NSDictionary<NSString*,NSString*>*) query
        params:(NSDictionary<NSString*,NSString*>*) params {
    id<iDirect> direct = [self.directors objectForKey:scheme];
    [direct push:[direct protocol] host:host pathname:pathname query:query params:params];
}

@end
 
