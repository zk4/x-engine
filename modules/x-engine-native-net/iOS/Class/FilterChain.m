//
//  FilterChain.m
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import "FilterChain.h"
@interface FilterChain()
@property (nonatomic, strong)   NSMutableArray*  filters;
@property (nonatomic, assign)   int pos;
@property (nonatomic, strong)   id<iNetAgent> http;
@end

@implementation FilterChain
- (instancetype)init {
    if (self = [super init]) {
        self.pos = 0;
    }
    return self;
}

-(void) setNetAgent:(id<iNetAgent>) agent{
    self.http= agent;
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

