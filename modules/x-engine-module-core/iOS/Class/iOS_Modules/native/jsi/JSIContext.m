//
//  JSIContext.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIContext.h"
#import "NativeContext.h"
#import "JSIModule.h"


@interface JSIContext ()
@property (nonatomic, strong) NSMutableSet<Class> *moduleClasses;
@property (nonatomic, strong) NSMutableArray<JSIModule *> *modules;
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
    for (JSIModule *module in self.modules) {
        [module afterAllJSIModuleInited];
    }
}
- (NSMutableArray *)modules {
    return _modules;
}
 
- (void)initModules {
    for (Class cls in self.moduleClasses) {
        id rawmoduleClass = [[cls alloc] init];
        JSIModule *moduleClass = (JSIModule *)rawmoduleClass;

        [self.modules addObject:moduleClass];
        NSLog(@"moudle found: %@", moduleClass.moduleId);
    }

    self.modules = [[self.modules sortedArrayUsingComparator:^(NativeModule *left, NativeModule *right) {
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
        @throw [NSException exceptionWithName:@"重复注册JSI moduleId" reason:@"不允许同名 JSI moduleId" userInfo:nil];
    }
    [self.moduleClasses addObject:cls];
}
@end
