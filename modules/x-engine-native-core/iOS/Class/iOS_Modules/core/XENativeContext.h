//
//  XENativeContext.h
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//


#import <Foundation/Foundation.h>

#define NATIVE_MODULE(clz) + (void)load{ \
    [[XENativeContext sharedInstance] registerModuleByClass:clz.class];}

// x-engine native module protocols
#define XENP(proto) [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(proto)]

@interface XENativeContext : NSObject
+ (instancetype)sharedInstance;

- (id) getModuleByProtocol:(Protocol *) proto;
- (id) getModuleById:(NSString*) moduleId;
- (NSMutableArray*) getModulesByProtocol:(Protocol *) proto;
- (void) registerModuleByClass:(Class)clazz;
- (void) start;

@end

