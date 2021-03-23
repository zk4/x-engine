//
//  aModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface aModule : NSObject
- (NSString *)moduleId;
- (int)order;
- (void)afterAllNativeModuleInited;
@end

NS_ASSUME_NONNULL_END
