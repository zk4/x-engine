//
//  DirectManagerModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "DirectManagerModule.h"
#import "NativeContext.h"
#import "iDirectManager.h"
#import "iDirect.h"
@interface DirectManagerModule ()
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iDirect>> * directors;
@end


@implementation DirectManagerModule
NATIVE_MODULE(DirectManagerModule)

- (id) init {
   if (self = [super init]) {
       self.directors=[NSMutableDictionary new];
   }
   return self;
}

- (NSString*) moduleId{
    return @"com.zkty.native.direct.manager";
}

- (int) order{
    return 0;
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