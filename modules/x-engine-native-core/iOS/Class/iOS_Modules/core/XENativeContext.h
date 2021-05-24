//
//  NativeContext.h
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//


#import <Foundation/Foundation.h>

#define NATIVE_MODULE(clz) + (void)load{ \
    [[NativeContext sharedInstance] registerModuleByClass:clz.class];}

// x-engine native module protocols
#define XENP(proto) [[NativeContext sharedInstance] getModuleByProtocol:@protocol(proto)]

@interface NativeContext : NSObject
+ (instancetype)sharedInstance;

- (id) getModuleByProtocol:(Protocol *) proto;
- (id) getModuleById:(NSString*) moduleId;
- (NSMutableArray*) getModulesByProtocol:(Protocol *) proto;
- (void) registerModuleByClass:(Class)clazz;
- (void) start;

@end

