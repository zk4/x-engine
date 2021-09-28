//
//  Native_rest.h
//  rest
//
//  Copyright © 2020 @zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FilterChain;

typedef void (^ZKResponse)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@protocol iFilter <NSObject>
    -(void) doFilter:(NSURLSession*) session request:(NSMutableURLRequest*) request  response:(ZKResponse) response chain:(FilterChain*) chain;
@end

@class OKHttp;
@protocol iNet
-(OKHttp*) build:(NSMutableURLRequest*) request;
-(OKHttp*) send:(ZKResponse) block;
-(OKHttp*) addFilter:(id<iFilter>) filter;
 @end

NS_ASSUME_NONNULL_END
