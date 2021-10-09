//
//  iKONet.h
//  iKONet
//
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol iKOFilterChain;

typedef void (^KOResponse)(id _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error);

@protocol iKOFilter
    // for debug
    -(NSString*) name;
    -(void) doFilter:(NSURLSession*) session request:(NSMutableURLRequest*) request  response:(KOResponse) KOResponse chain:(id<iKOFilterChain>) chain;
@end


//网络的实现类
@protocol iKONetAgent
    typedef NSMutableArray* KOPipeline;
    -(id<iKONetAgent>) send:(NSMutableURLRequest*)reqeust response:(KOResponse) block;
    -(id<iKONetAgent>) addFilter:(id<iKOFilter>) filter;
    -(id<iKONetAgent>) activePipeline:(KOPipeline) pipeline;
    - (void) activePipelineByName:(NSString*) name;
@end

// 供引擎使用拿到 agent
@protocol iKONetManager
    - (nonnull id<iKONetAgent>) one;
@end

@protocol iKOFilterChain
    -(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(KOResponse) KOResponse;
@end

NS_ASSUME_NONNULL_END
