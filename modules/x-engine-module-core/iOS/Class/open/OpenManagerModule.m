//
//  OpenManagerModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zk. All rights reserved.
//

#import "OpenManagerModule.h"
#import "XEngineContext.h"
#import "iOpen.h"
@interface OpenManagerModule ()
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iOpen>> * openers;
@end


@implementation OpenManagerModule
NATIVE_MODULE(OpenManagerModule)

- (id) init {
   if (self = [super init]) {
       self.openers=[NSMutableDictionary new];
   }
   return self;
}

- (NSString*) moduleId{
    return @"com.zkty.native.openmanager";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
   NSArray* modules= [[XEngineContext sharedInstance]  getModulesByProtocol:@protocol(iOpen)];
    for(id<iOpen> opener in modules){
        [self.openers setObject:opener forKey:[opener type]];
    }
}



- (void)open:(nonnull NSString *)type :(nonnull NSString *)uri :(nonnull NSString *)path :(nonnull NSDictionary *)args :(long)version :(BOOL)isHidden {
    id<iOpen> opener = [self.openers objectForKey:type];
    [opener open:type :uri :path :args :version :isHidden];
}

@end
