//
//  iNet.h
//  iNet
//
//  Copyright © 2021 x-engine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol iFilterChain;

typedef void (^ZKResponse)(id _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error);

@protocol iFilter
    -(void) doFilter:(NSURLSession*) session request:(NSMutableURLRequest*) request  response:(ZKResponse) zkResponse chain:(id<iFilterChain>) chain;
    // DEMO: 过滤服务器错误
    //[chain doFilter:session request:request response:^(id _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
    //    NSHTTPURLResponse* hres = (NSHTTPURLResponse*) res;
    //    if(hres.statusCode != 200){
    //        NSString* msg =[NSString stringWithFormat:@"服务器错误，返回了%ld, 不会回调到业务，开发人员请注意。" ,hres.statusCode];
    //        NSLog(@"%@",msg);
    //        [XENP(iToast) toast:msg];
    //        return;
    //    }else{
    //        response(data,res,error);
    //    }
    //}];
@end


//网络的实现类，可以是原生，也可以是 afnetworking
@protocol iNetAgent
-(id<iNetAgent>) build:(NSMutableURLRequest*) request;
-(id<iNetAgent>) send:(ZKResponse) block;
-(id<iNetAgent>) addFilter:(id<iFilter>) filter;
-(id<iNetAgent>) _internalSend:(ZKResponse)block;
 @end

// 供引擎使用拿到 agent
@protocol iNetManager
- (nonnull id<iNetAgent>) one;
@end

@protocol iFilterChain
-(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(ZKResponse) zkResponse;
-(id<iFilterChain>) addFilter:(id<iFilter>) filter;
-(void) setNetAgent:(id<iNetAgent>) agent;
@end

NS_ASSUME_NONNULL_END
