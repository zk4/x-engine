//
//  OKHttp.m
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import "OKHttp.h"

@implementation iRequest

@end

@interface OKHttp()
    @property (nonatomic, strong)   iRequest* request;
    @property (nonatomic, strong)   NSMutableArray*  interceptors;
    @property (nonatomic, strong)   AFHTTPSessionManager* af;
@end

@implementation OKHttp
-(OKHttp*) build:(iRequest*) request{
    self.request = request;
    return self;
}

// userInterceptor1 -> userInterceptor2 -> realReuqest -> realResponse
// userInterceptor1 <- userInterceptor2 <- realReuqest <- realResponse
-(OKHttp*) addInterceptor:(id<iInterceptor>) interceptor {
    if(!self.interceptors){
        self.interceptors=[NSMutableArray new];
    }
    [self.interceptors addObject:interceptor];
    return self;
}

-(OKHttp*) send:(ZKRequestCallBack) block{
    self.af = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: self.request.baseurl]];
    for(id<iInterceptor> interceptor in self.interceptors){
        [interceptor intercept:self.af withRequest:self.request];
    }
    [self.af GET:self.request.path parameters:self.request.queries  headers:self.request.headers   progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
    return self;
}



@end
