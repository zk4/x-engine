//
//  FilterChain.h
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iNet.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterChain :NSObject <iFilterChain>
-(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(ZKResponse) zkResponse;
-(FilterChain*) addFilter:(id<iFilter>) filter;
-(void) setNetAgent:(id<iNetAgent>) agent;
@end


NS_ASSUME_NONNULL_END
