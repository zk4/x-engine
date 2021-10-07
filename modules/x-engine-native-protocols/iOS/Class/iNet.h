//
//  iNet.h
//  iNet
//
//  Copyright © 2021 x-engine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol iFilterChain;

typedef void (^KOResponse)(id _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error);

@protocol iFilter
    -(void) doFilter:(NSURLSession*) session request:(NSMutableURLRequest*) request  response:(KOResponse) KOResponse chain:(id<iFilterChain>) chain;
@end


//网络的实现类
@protocol iNetAgent
typedef NSMutableArray* KOPipeline;
    -(id<iNetAgent>) build:(NSMutableURLRequest*) request;
    -(id<iNetAgent>) send:(KOResponse) block;
    -(id<iNetAgent>) addFilter:(id<iFilter>) filter;
    -(id<iNetAgent>) activePipeline:(KOPipeline) pipeline;
@end

// 供引擎使用拿到 agent
@protocol iNetManager
    - (nonnull id<iNetAgent>) one;
@end

@protocol iFilterChain
    -(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(KOResponse) KOResponse;
@end

NS_ASSUME_NONNULL_END
