//
//  xengine__module_lope.h
//  lope
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <micros.h>
#import "xengine__module_lope.h"

NS_ASSUME_NONNULL_BEGIN
@class SheetDTO;
@interface __xengine__module_lope : xengine__module_lope 
- (void)_initSdkAndConfigure:(LopePIDDTO *)dto complete:(void (^)(LopeRetStatusDTO *, BOOL))completionHandler;
 @end

NS_ASSUME_NONNULL_END
