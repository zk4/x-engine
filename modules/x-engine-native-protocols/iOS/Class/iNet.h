//
//  iNet.h
//  iNet
//
//  Copyright © 2021 x-engine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FilterChain;

typedef void (^ZKResponse)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@protocol iFilter <NSObject>
    -(void) doFilter:(NSURLSession*) session request:(NSMutableURLRequest*) request  response:(ZKResponse) response chain:(FilterChain*) chain;
@end


//网络的实现类，可以是原生，也可以是 afnetworking
@protocol iNetAgent
-(id<iNetAgent>) build:(NSMutableURLRequest*) request;
-(id<iNetAgent>) send:(ZKResponse) block;
-(id<iNetAgent>) addFilter:(id<iFilter>) filter;
 @end

// 供引擎使用拿到 agent
@protocol iNetManager
- (nonnull id<iNetAgent>) one;
@end



NS_ASSUME_NONNULL_END
