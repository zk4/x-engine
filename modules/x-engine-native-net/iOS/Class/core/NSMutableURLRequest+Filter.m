//
//  NSMutableURLRequest+Filter.m
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
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

#import "NSMutableURLRequest+Filter.h"
#import <objc/runtime.h>
#import "KOHttp.h"

@interface NSMutableURLRequest(KOFilter)

@end

@implementation NSMutableURLRequest(KOFilter)

- (id<iKONetAgent>)koagent
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setKoagent:(id<iKONetAgent>)agent
{
    objc_setAssociatedObject(self, @selector(koagent), agent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void) addFilter:(id<iKOFilter>) filter{

    if(!self.koagent){
        self.koagent = [KOHttp new];
    }
    [self.koagent addFilter:filter];
}
-(void) activePipeline:(KOPipeline) pipeline{

    if(!self.koagent){
        self.koagent = [KOHttp new];
    }
    [self.koagent activePipeline:pipeline];
}

- (void) activePipelineByName:(NSString*) name{
    if(!self.koagent){
        self.koagent = [KOHttp new];
    }
    
    KOPipeline pipeline =  [KOHttp ko_globalPipelines][name];
    NSAssert(pipeline, @"没有 pipeline");
    
    if(pipeline){
        [self.koagent activePipeline:pipeline];
    }
}

 
-(void) send:(KOResponse) block{

    if(!self.koagent){
        self.koagent = [KOHttp new];
    }
    [self.koagent send:self response:^(id _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data,response,error);
    }];

}


- (void)dealloc{
    objc_setAssociatedObject(self, @selector(koagent), nil, OBJC_ASSOCIATION_ASSIGN);
}

@end
