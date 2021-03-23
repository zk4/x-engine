//
//  MicroAppContext.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zk. All rights reserved.
//

#import "MicroAppContext.h"
#import "XEngineContext.h"
#import "aJSIModule.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>

@interface MicroAppContext ()
@property (nonatomic, strong) NSMutableArray<Class> *moduleClasses;
@property (nonatomic, strong) NSMutableArray<aJSIModule *> *modules;
@end

@implementation MicroAppContext
NATIVE_MODULE(MicroAppContext)
- (NSString *)moduleId {
    return @"com.zkty.native.context";
}

+ (instancetype)sharedInstance {
    static MicroAppContext *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedInstance = [[MicroAppContext alloc] init];
      sharedInstance.moduleClasses =[NSMutableArray new];
      sharedInstance.modules = [NSMutableArray array];


    });
    return sharedInstance;
}
- (void)start {
    [self initModules];
}

- (NSMutableArray *)modules {
    return _modules;
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
        aJSIModule *moduleClass = (aJSIModule *)rawmoduleClass;

        [self.modules addObject:moduleClass];
        NSLog(@"moudle found: %@", moduleClass.JSImoduleId);
    }

    self.modules = [[self.modules sortedArrayUsingComparator:^(aModule *left, aModule *right) {
      if ([left order] > [right order]) {
          return NSOrderedDescending;
      } else if ([left order] < [right order]) {
          return NSOrderedAscending;
      }
      return NSOrderedSame;
    }] mutableCopy];
}
- (void)registerModuleByClass:(Class)cls {
    [self.moduleClasses addObject:cls];
}
@end
