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

// 将 a.b.c　转换为　a*10000+ b*100 +c  得到一个 long
- (long) getVersion;
- (id) getModuleByProtocol:(Protocol *) proto;
- (id) getModuleById:(NSString*) moduleId;
- (NSMutableArray*) getModulesByProtocol:(Protocol *) proto;
- (void) registerModuleByClass:(Class)clazz;
- (void) start;

@end

