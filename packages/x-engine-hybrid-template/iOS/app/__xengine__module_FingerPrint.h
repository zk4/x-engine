//
//  __xengine__module_FingerPrint.h
//  XEngineSDKDemo
//
//  Created by edz on 2020/7/29.
//  Copyright © 2020 edz. All rights reserved.
//

#import "xengine__module_BaseModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface __xengine__module_FingerPrint : xengine__module_BaseModule
- (void)verificationFingerPrint:(NSDictionary *)data callBack:(XEngineCallBack)completionHandler;
@end

NS_ASSUME_NONNULL_END
