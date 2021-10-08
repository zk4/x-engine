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
#import "XENativeContext.h"
#import "KOHttp.h"

// 有个问题，如果这个类做主类使用， 则 KOHTTP 里的 NSMutableURLRequest 则不能是强引用。。 不然 KOHTTP 无法释放
@interface NSMutableURLRequest(KOFilter)
@end

@implementation NSMutableURLRequest(KOFilter)

- (id<iNetAgent>)koagent
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setKoagent:(id<iNetAgent>)agent
{
    objc_setAssociatedObject(self, @selector(koagent), agent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(id<iNetAgent>) addFilter:(id<iFilter>) filter{

    if(!self.koagent){
        self.koagent = [[KOHttp new] build:self];
    }

    [self.koagent addFilter:filter];
    return self.koagent;
}
-(id<iNetAgent>) activePipeline:(KOPipeline) pipeline{

    if(!self.koagent){
        self.koagent = [[KOHttp new] build:self];
    }

    [self.koagent activePipeline:pipeline];
    return self.koagent;
}
-(id<iNetAgent>) send:(KOResponse) block{

    if(!self.koagent){
        self.koagent = [[KOHttp new] build:self];
    }

    [self.koagent send:^(id _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data,response,error);
    }];
    return self.koagent;
}

- (void)dealloc{
    objc_setAssociatedObject(self, @selector(koagent), nil, OBJC_ASSOCIATION_ASSIGN);
    NSLog(@"hello");
}
@end
