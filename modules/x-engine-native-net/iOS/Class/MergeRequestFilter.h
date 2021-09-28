//
//  MergeRequestFilter.h
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iNet.h"
NS_ASSUME_NONNULL_BEGIN


@interface MergeRequestFilter:NSObject <iFilter>
@property (atomic, strong)   NSMutableDictionary<NSString*,NSMutableArray*>* requests;
@end



NS_ASSUME_NONNULL_END
