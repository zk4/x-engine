//
//  aJSIModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface aJSIModule : NSObject
- (NSString*) moduleId;
- (int) order;
- (void) afterAllJSIModuleInited;

- (id) convert:(NSDictionary *)param  clazz:(Class)clazz;

@end

NS_ASSUME_NONNULL_END
