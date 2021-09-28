//
//  OKHttp.m
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import "OKHttp.h"
@interface FilterChain()
@property (nonatomic, strong)   NSMutableArray*  filters;
@property (nonatomic, assign)   int pos;
@property (nonatomic, strong)   OKHttp* http;
@end

@implementation FilterChain
- (instancetype)init {
    if (self = [super init]) {
        self.pos = 0;
    }
    return self;
}

-(void) setOKHttp:(OKHttp*) okhttp{
    self.http = okhttp;
}

-(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(ZKResponse) zkResponse{
    if(self.pos<self.filters.count){
        id<iFilter> filter =  [self.filters objectAtIndex:self.pos++];
        [filter doFilter:session request:request  response:zkResponse chain:self];
    }else{
        [self.http _internalSend:zkResponse];
    }
}
-(FilterChain*) addFilter:(id<iFilter>) filter {
    if(!self.filters){
        self.filters=[NSMutableArray new];
    }
    [self.filters addObject:filter];
    return self;
}
@end


@interface OKHttp()
@property (nonatomic, strong)   NSMutableURLRequest* request;
@property (nonatomic, strong)   NSURLSession *session;
@property (nonatomic, strong)   FilterChain *chain;
@end

@implementation OKHttp

-(OKHttp*) build:(NSMutableURLRequest*) request{
    self.request = request;
    return self;
}

-(OKHttp*) addFilter:(id<iFilter>) filter{
    if(!self.chain){
        self.chain = [FilterChain new];
        [self.chain setOKHttp:self];
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
