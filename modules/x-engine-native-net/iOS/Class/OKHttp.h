//
//  XENetClient.h
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FilterChain;
@class OKHttp;

//typedef void (^ZKSimpleResponse)(id _Nullable result, NSError* _Nullable error);
typedef void (^ZKResponse)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@protocol iFilter <NSObject>
    -(void) doFilter:(NSURLSession*) session request:(NSMutableURLRequest*) request  response:(ZKResponse) response chain:(FilterChain*) chain;
@end


@interface FilterChain :NSObject
-(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(ZKResponse) zkResponse;
-(FilterChain*) addFilter:(id<iFilter>) filter;
-(void) setOKHttp:(OKHttp*) okhttp;
@end


@interface OKHttp : NSObject
-(OKHttp*) build:(NSMutableURLRequest*) request;
-(OKHttp*) send:(ZKResponse) block;
-(OKHttp*) addFilter:(id<iFilter>) filter;
-(OKHttp*) _internalSend:(ZKResponse)block;

@end

NS_ASSUME_NONNULL_END
