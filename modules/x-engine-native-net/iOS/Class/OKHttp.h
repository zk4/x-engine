//
//  XENetClient.h
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iNet.h>

NS_ASSUME_NONNULL_BEGIN

@interface OKHttp : NSObject <iNetAgent>
-(OKHttp*) build:(NSMutableURLRequest*) request;
-(OKHttp*) send:(ZKResponse) block;
-(OKHttp*) addFilter:(id<iFilter>) filter;
-(OKHttp*) _internalSend:(ZKResponse)block;

@end

NS_ASSUME_NONNULL_END
