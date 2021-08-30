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

#ifdef DEBUG

#  define NSLog(fmt, ...) do {                                            \
NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
NSLog((@"%@(%d) " fmt), [file lastPathComponent], __LINE__, ##__VA_ARGS__); \
} while(0)
#else
# define NSLog(...);
#endif

@interface JSIContext : XENativeModule
+ (instancetype)sharedInstance;
- (void) registerModuleByClass:(Class)clazz;
- (void) start;
- (NSMutableArray *)modules;
@end

NS_ASSUME_NONNULL_END
