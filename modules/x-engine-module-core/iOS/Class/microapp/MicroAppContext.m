//
//  MicroAppContext.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 edz. All rights reserved.
//

#import "MicroAppContext.h"
#import "XEngineContext.h"
#import "aJSIModule.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>

@interface MicroAppContext ()
@property (nonatomic, strong) NSMutableArray<NSString *> *moduleClassNames;
@property (nonatomic, strong) NSMutableArray<aJSIModule *> *modules;
@property (nonatomic, strong) NSMutableArray *applicationDelegateModules;
@property (nonatomic, strong) NSMutableDictionary<NSString *, aJSIModule *> *moduleId2Moudle;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *moduleId2MoudleProtocolnames;

@end
@implementation MicroAppContext
NATIVE_MODULE(MicroAppContext)
- (NSString *)moduleId {
    return @"com.module.microapp.context";
}

+ (instancetype)sharedInstance {
    static MicroAppContext *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedInstance = [[MicroAppContext alloc] init];

      sharedInstance.modules = [NSMutableArray array];
      sharedInstance.applicationDelegateModules = [NSMutableArray array];
      sharedInstance.moduleId2Moudle = [[NSMutableDictionary alloc] init];
      sharedInstance.moduleId2MoudleProtocolnames = [[NSMutableDictionary alloc] init];
    });
    return sharedInstance;
}

- (NSMutableArray *)modules {
    return _modules;
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

- (void)registerModuleByClass:(Class)cls {
    id rawmoduleClass = [[cls alloc] init];
    aJSIModule *moduleClass = (aJSIModule *)rawmoduleClass;
    NSString *JSImoduleId = [moduleClass JSImoduleId];

    [self.moduleId2Moudle setObject:moduleClass forKey:moduleClass.JSImoduleId];

    NSMutableArray *protocols = [self getProtocols:cls];
    [self.moduleId2MoudleProtocolnames setObject:protocols forKey:JSImoduleId];

    [self.modules addObject:moduleClass];
    NSLog(@"JSI found: %@", moduleClass.JSImoduleId);
}
@end
