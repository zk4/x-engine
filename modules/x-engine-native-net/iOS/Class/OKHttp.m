//
//  OKHttp.m
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import "OKHttp.h"
#import "FilterChain.h"

@interface OKHttp()
@property (nonatomic, strong)   NSMutableURLRequest* request;
@property (nonatomic, strong)   NSURLSession *session;
@property (nonatomic, strong)   id<iFilterChain> chain;
@end

@implementation OKHttp

-(OKHttp*) build:(NSMutableURLRequest*) request{
    self.request = request;
    return self;
}

-(OKHttp*) addFilter:(id<iFilter>) filter{
    if(!self.chain){
        self.chain = [FilterChain new];
        [self.chain setNetAgent:self];
    }
    [self.chain addFilter:filter];
    return self;
}

-(OKHttp*) _internalSend:(ZKResponse)block{
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:nil];
    
    NSURLSessionDataTask *sessionTask = [self.session dataTaskWithRequest:self.request completionHandler:block];
    [sessionTask resume];
    return self;
}
-(OKHttp*) send:(ZKResponse) block{
    [self.chain doFilter:self.session request:self.request response:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data,response,error);
    }];
    return self;
}
@end
