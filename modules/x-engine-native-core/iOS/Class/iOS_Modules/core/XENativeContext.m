//
//  EngineContext.m
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "XENativeContext.h"
#import "XENativeModule.h"
#import <objc/message.h>

@interface XENativeContext ()
// 维护通过 load 注册过来的 class
@property (nonatomic, strong) NSMutableSet<Class> *moduleClasses;
// 实例化后的 modules, 因为 module 有 order，使用 NSMutableArray 维护顺序
@property (nonatomic, strong) NSMutableArray<XENativeModule *> *modules;
// moduleid 映射的 module
@property (nonatomic, strong) NSMutableDictionary<NSString *, XENativeModule *> *moduleId2Moudle;
// module 对应的 protocols
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *moduleId2MoudleProtocolnames;

@end
 

@implementation XENativeContext
+ (void) showEngineVersion{
    NSLog(@"x-engine version: 2.0.0");
}
+ (void)load {
    [XENativeContext showEngineVersion];
    
// demo
// 在各自对应的模块中重写 + load方法,监听UIApplicationDidFinishLaunchingNotification通知
//    __block id observer =
//        [[NSNotificationCenter defaultCenter]
//            addObserverForName:UIApplicationDidFinishLaunchingNotification
//                        object:nil
//                         queue:nil
//                    usingBlock:^(NSNotification *note) {
//                      [[XENativeContext sharedInstance] start];
//                      [[NSNotificationCenter defaultCenter] removeObserver:observer];
//                    }];
    
}
+ (instancetype)sharedInstance {
    static XENativeContext *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XENativeContext alloc] init];
        sharedInstance.moduleClasses =[NSMutableSet new];
        sharedInstance.modules = [NSMutableArray array];
        sharedInstance.moduleId2Moudle = [[NSMutableDictionary alloc] init];
        sharedInstance.moduleId2MoudleProtocolnames = [[NSMutableDictionary alloc] init];
    });
    return sharedInstance;
}

- (void)start {
    printf("%s\n","---必须保证 Native 模块首先初始化。--- start");
    [self initModules];
    [self afterAllNativeModuleInited];
    printf("%s\n","---必须保证 Native 模块首先初始化。--- end");
}
 
 
- (id)getModuleById:(NSString *)moduleId {
    return [self.moduleId2Moudle objectForKey:moduleId];
}

- (NSMutableArray *)getProtocols:(Class)cls {
    unsigned count;
    __unsafe_unretained Protocol **pl = class_copyProtocolList(cls, &count);

    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:count];

    for (unsigned i = 0; i < count; i++) {
        NSString *name = [NSString stringWithUTF8String:protocol_getName(pl[i])];
        [ret addObject:name];
    }
    free(pl);
    return ret;
}

- (void)initModules {
    for (Class cls in self.moduleClasses) {
        id rawmoduleClass = [[cls alloc] init];
        XENativeModule *moduleClass = (XENativeModule *)rawmoduleClass;
        NSString *moduleId = [moduleClass moduleId];

        [self.moduleId2Moudle setObject:moduleClass forKey:moduleClass.moduleId];

        NSMutableArray *protocols = [self getProtocols:cls];
        [self.moduleId2MoudleProtocolnames setObject:protocols forKey:moduleId];

        [self.modules addObject:moduleClass];
        NSLog(@"moudle found: %@", moduleClass.moduleId);
    }

    self.modules = [[self.modules sortedArrayUsingComparator:^(XENativeModule *left, XENativeModule *right) {
      if ([left order] > [right order]) {
          return NSOrderedDescending;
      } else if ([left order] < [right order]) {
          return NSOrderedAscending;
      }
      return NSOrderedSame;
    }] mutableCopy];

}

- (id)getModuleByProtocol:(Protocol *)proto {
    // if found multipal modules, choose only the first found, or you can call getModulesByProtocol:
    NSString *protocoalName = NSStringFromProtocol(proto);
    for (NSString *moduleId in self.moduleId2MoudleProtocolnames) {
        NSMutableArray *protocolNames = [self.moduleId2MoudleProtocolnames objectForKey:moduleId];
        if ([protocolNames containsObject:protocoalName]) {
            return [self.moduleId2Moudle objectForKey:moduleId];
        }
    }
    return nil;
}
- (void) afterAllNativeModuleInited{
    for (XENativeModule *module in self.modules) {
        [module afterAllNativeModuleInited];
    }
}
- (NSMutableArray *)getModulesByProtocol:(Protocol *)proto {
    NSMutableArray *modules = nil;
    NSString *protocoalName = NSStringFromProtocol(proto);
    for (NSString *moduleId in self.moduleId2MoudleProtocolnames) {
        NSMutableArray *protocolNames = [self.moduleId2MoudleProtocolnames objectForKey:moduleId];
        if ([protocolNames containsObject:protocoalName]) {
            if (!modules) {
                // lazy init
                modules = [NSMutableArray array];
            }
            [modules addObject:[self.moduleId2Moudle objectForKey:moduleId]];
        }
    }
    return modules;
}


- (void)registerModuleByClass:(Class)clazz {
    if([self.moduleClasses containsObject:clazz]){
        @throw [NSException exceptionWithName:@"重复注册native clazz" reason:@"不允许同名 native clazz" userInfo:nil];
    }
    [self.moduleClasses addObject:clazz];
}

@end