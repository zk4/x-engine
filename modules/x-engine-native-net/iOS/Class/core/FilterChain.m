//
//  FilterChain.m
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 x-engine. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE./

#import "FilterChain.h"
@interface FilterChain()
@property (atomic, strong)   NSMutableArray*  filters;
@property (nonatomic, assign)   int pos;
// agent is hold by it's self. weak it
// if agent die. filters chains should die along.
@property (nonatomic, weak)   id<iNetAgent> agent;
@end

@implementation FilterChain
- (instancetype)init {
    if (self = [super init]) {
        self.pos = 0;
    }
    return self;
}

-(void) setNetAgent:(id<iNetAgent>) agent{
    self.agent= agent;
}

-(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(ZKResponse) zkResponse{
    if(self.pos<self.filters.count){
        id<iFilter> filter =  [self.filters objectAtIndex:self.pos++];
        __weak typeof(self) weakSelf = self;
        [filter doFilter:session request:request  response:zkResponse chain:weakSelf];
    }else{
        [self.agent _internalSend:zkResponse];
    }
}
-(id<iFilterChain>) addFilter:(id<iFilter>) filter {
    if(!self.filters){
        self.filters=[NSMutableArray new];
    }
    [self.filters addObject:filter];
    return self;
}
@end

