//
//  RNContext.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "aRNModule.h"
NS_ASSUME_NONNULL_BEGIN
#define RN_MODULE(clz) + (void)load{ \
    [[JSIContext sharedInstance] registerModuleByClass:clz.class];}\

@interface RNContext : aRNModule
+ (instancetype)sharedInstance;
- (void) registerModuleByClass:(Class)clazz;
- (void) start;
@end

NS_ASSUME_NONNULL_END
