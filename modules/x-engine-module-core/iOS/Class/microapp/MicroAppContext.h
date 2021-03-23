//
//  MicroAppContext.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "aModule.h"
NS_ASSUME_NONNULL_BEGIN
#define JSI_MODULE(clz) + (void)load{ \
    [[MicroAppContext sharedInstance] registerModuleByClass:clz.class];}\

@interface MicroAppContext : aModule
+ (instancetype)sharedInstance;
- (void) registerModuleByClass:(Class)clazz;
- (void) start;
@end

NS_ASSUME_NONNULL_END
