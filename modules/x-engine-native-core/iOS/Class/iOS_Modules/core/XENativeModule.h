//
//  XENativeModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 x-engine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XENativeModule : NSObject
- (NSString *)moduleId;
- (int)order;
- (void)afterAllNativeModuleInited;
@end

NS_ASSUME_NONNULL_END
