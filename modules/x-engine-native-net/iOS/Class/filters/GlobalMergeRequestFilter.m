//
//  GlobalMergeRequestFilter.m
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

#import "GlobalMergeRequestFilter.h"

@interface GlobalMergeRequestFilter()
@property (atomic, strong)   NSMutableDictionary<NSString*,NSMutableArray*>* requests;
@end
@implementation GlobalMergeRequestFilter
+ (id)sharedInstance
{
    static GlobalMergeRequestFilter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.requests=[[NSMutableDictionary alloc] init];
        
    });
    return sharedInstance;
}


- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)response chain:(id<iFilterChain>) chain {
    
    if(![request.HTTPMethod isEqualToString:@"GET"]){
        [chain doFilter:session request:request response:response];
        return;
    }
    NSString* key = request.URL.absoluteString;
    id queue =  [self.requests objectForKey:key];
    if(queue){
        NSLog(@"merged request %ld",((NSMutableArray*)queue).count);
        [queue addObject:response];
        return;
    }else{
        @synchronized (self){
            NSMutableArray* queue = [NSMutableArray new];
            [queue addObject:response];
            [self.requests setObject:queue forKey:key];
        }
        __weak typeof(self) weakSelf = self;
        [chain doFilter:session request:request response:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
             NSMutableArray* queue =  [weakSelf.requests objectForKey:key];
            @synchronized (weakSelf){
                for (long i = queue.count-1 ; i >= 0 ; i--) {
                    KOResponse r = queue[i];
                    r(data,res,error);
                    r = nil;
                }
            }
            [weakSelf.requests removeObjectForKey:key];
        }];
    }
}

- (nonnull NSString *)name {
    return @"全局合并请求 filter";
}

@end
