//
//  RNContext.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "RNContext.h"
#import "XEngineContext.h"
#import "aRNModule.h"


@interface RNContext ()
@property (nonatomic, strong) NSMutableSet<Class> *moduleClasses;
@property (nonatomic, strong) NSMutableArray<aRNModule *> *modules;
@end

@implementation RNContext
NATIVE_MODULE(RNContext)
- (NSString *)moduleId {
    return @"com.zkty.rn.context";
}

+ (instancetype)sharedInstance {
    static RNContext *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedInstance = [[RNContext alloc] init];
      sharedInstance.moduleClasses =[NSMutableSet new];
      sharedInstance.modules = [NSMutableArray array];


    });
    return sharedInstance;
}
- (void)start {
    [self initModules];
    [self afterAllJSIModuleInited];
}
- (void) afterAllJSIModuleInited{
    for (aRNModule *module in self.modules) {
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
    if([self.moduleClasses containsObject:cls]){
        @throw [NSException exceptionWithName:@"重复注册RN moduleId" reason:@"不允许同名 RN moduleId" userInfo:nil];
    }
    [self.moduleClasses addObject:cls];
}
@end
