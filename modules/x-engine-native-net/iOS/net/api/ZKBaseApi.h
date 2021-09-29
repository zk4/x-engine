//
//  ZKBaseApi.h
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableURLRequest+Filter.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKBaseApi : NSObject

@property(nonatomic,strong) NSMutableURLRequest* req;
- (NSString*) getMethod;
- (void) addLocalFilter:(NSMutableURLRequest*) req;
- (NSString*) getUrl;
@end

NS_ASSUME_NONNULL_END
