//
//  JSIContext.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIContext.h"
#import "XENativeContext.h"
#import "JSIModule.h"

static NSMutableSet<Class> *moduleClasses;
@interface JSIContext ()
@property (nonatomic, strong) NSMutableArray<JSIModule *> *modules;
@end

@implementation JSIContext
NATIVE_MODULE(JSIContext)
- (NSString *)moduleId {
    return @"com.zkty.native.jsicontext";
}

 
- (void) afterAllNativeModuleInited{
    self.modules  = [NSMutableArray new];
    [self initModules];
    for (JSIModule *module in self.modules) {
        [module afterAllJSIModuleInited];
    }
}
- (NSMutableArray *)getJSIModules {
    return _modules;
}
 
- (void)initModules {
    for (Class cls in moduleClasses) {
        id rawmoduleClass = [[cls alloc] init];
        JSIModule *moduleClass = (JSIModule *)rawmoduleClass;

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
+ (void)registerModuleByClass:(Class)cls {
    if(!moduleClasses){
        moduleClasses= [NSMutableSet new];
    }
    if([moduleClasses containsObject:cls]){
        @throw [NSException exceptionWithName:@"重复注册JSI moduleId" reason:@"不允许同名 JSI moduleId" userInfo:nil];
    }
    [moduleClasses addObject:cls];
}
@end
