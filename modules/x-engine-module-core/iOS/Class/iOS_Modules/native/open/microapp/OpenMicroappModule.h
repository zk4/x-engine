//
//  OpenMicroappModule.m.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NativeModule.h"
#import "iOpen.h"
NS_ASSUME_NONNULL_BEGIN

@interface OpenMicroappModule : NativeModule <iOpen>
+ (NSString * _Nullable) s_microapp_root_url;
@end

NS_ASSUME_NONNULL_END
