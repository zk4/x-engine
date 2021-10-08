//
//  KOHttp.m
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

#import "KOHttp.h"

#ifdef DEBUG
#  define NSLog(fmt, ...) do {                                            \
NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
NSLog((@"%@(%d) " fmt), [file lastPathComponent], __LINE__, ##__VA_ARGS__); \
} while(0)
#else
# define NSLog(...);
#endif


@interface KOHttp()
@property (nonatomic, strong)   NSMutableURLRequest* request;
@property (nonatomic, strong)   NSURLSession *session;

@property (atomic, strong)   NSMutableArray*  filters;
@property (nonatomic, assign)   int pos;
@end

@implementation KOHttp

-(id<iNetAgent>) build:(NSMutableURLRequest*) request{
    self.request = request;
    return self;
}

-(id<iNetAgent>) addFilter:(id<iFilter>) filter{
    @synchronized (self) {
        if(!self.filters){
            self.filters=[NSMutableArray new];
        }
    }
    [self.filters addObject:filter];
    return self;
}

- (nonnull id<iNetAgent>) activePipeline:(nonnull KOPipeline)pipeline {
    self.filters = pipeline;
    return self;
}

-(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(KOResponse) KOResponse{
    if(self.pos<self.filters.count){
        id<iFilter> filter =  [self.filters objectAtIndex:self.pos++];
        __weak typeof(self) weakSelf = self;
        NSLog(@"%@ 处理中...",[filter name]);
        [filter doFilter:session request:request  response:KOResponse chain:weakSelf];
    }else{
        [self _internalSend:KOResponse];
    }
}

-(id<iNetAgent>) _internalSend:(KOResponse)block{
    self.session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionTask = [self.session dataTaskWithRequest:self.request completionHandler:block];
    [sessionTask resume];
    return self;
}
-(id<iNetAgent>) send:(KOResponse) block{
    [self doFilter:self.session request:self.request response:^(id _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data,response,error);
    }];
    return self;
}

- (void)dealloc{
    NSLog(@"dealloc");
}
@end
