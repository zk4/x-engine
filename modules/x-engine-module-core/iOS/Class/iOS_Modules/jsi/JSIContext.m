//
//  JSIContext.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIContext.h"
#import "XEngineContext.h"
#import "aJSIModule.h"


@interface JSIContext ()
@property (nonatomic, strong) NSMutableArray<Class> *moduleClasses;
@property (nonatomic, strong) NSMutableArray<aJSIModule *> *modules;
@end

@implementation JSIContext
NATIVE_MODULE(JSIContext)
- (NSString *)moduleId {
    return @"com.zkty.native.context";
}

+ (instancetype)sharedInstance {
    static JSIContext *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedInstance = [[JSIContext alloc] init];
      sharedInstance.moduleClasses =[NSMutableArray new];
      sharedInstance.modules = [NSMutableArray array];


    });
    return sharedInstance;
}
- (void)start {
    [self initModules];
    [self afterAllJSIModuleInited];
}
- (void) afterAllJSIModuleInited{
    for (aJSIModule *module in self.modules) {
        [module afterAllJSIModuleInited];
    }
}
- (NSMutableArray *)modules {
    return _modules;
}
 
- (void)initModules {
    for (Class cls in self.moduleClasses) {
        id rawmoduleClass = [[cls alloc] init];
        aJSIModule *moduleClass = (aJSIModule *)rawmoduleClass;

        [self.modules addObject:moduleClass];
        NSLog(@"moudle found: %@", moduleClass.moduleId);
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
