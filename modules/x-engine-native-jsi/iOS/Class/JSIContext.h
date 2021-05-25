//
//  JSIContext.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XENativeModule.h"
NS_ASSUME_NONNULL_BEGIN
#define JSI_MODULE(clz) + (void)load{ \
    [[JSIContext sharedInstance] registerModuleByClass:clz.class];}\

@interface JSIContext : XENativeModule
+ (instancetype)sharedInstance;
- (void) registerModuleByClass:(Class)clazz;
- (void) start;
- (NSMutableArray *)modules;
@end

NS_ASSUME_NONNULL_END
