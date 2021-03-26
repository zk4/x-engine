//
//  TestModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "aJSIModule.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^XEngineCallBack)(id _Nullable result,BOOL complete);

@interface JSIOpenModule : aJSIModule

@end

NS_ASSUME_NONNULL_END

