//
//  iOpen.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iOpenManager.h"
NS_ASSUME_NONNULL_BEGIN

@protocol iOpen <iOpenManager>
-(NSString*) type;
@end

NS_ASSUME_NONNULL_END
