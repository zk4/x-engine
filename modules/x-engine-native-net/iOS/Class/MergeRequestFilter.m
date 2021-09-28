//
//  MergeRequestFilter.m
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

#import "MergeRequestFilter.h"

@implementation MergeRequestFilter

- (instancetype)init {
    if (self = [super init]) {
        self.requests=[[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    NSString* key = request.URL.absoluteString;
    id queue =  [self.requests objectForKey:key];
    if(queue){
        NSLog(@"merged request %ld",((NSMutableArray*)queue).count);
        [queue addObject:response];
        return;
    }else{
        NSMutableArray* queue = [NSMutableArray new];
        [queue addObject:response];
        [self.requests setObject:queue forKey:key];
//        __weak typeof(self) weakSelf = self;
        [chain doFilter:session request:request response:^(NSData * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
//            __strong typeof(self) strongSelf = weakSelf;
            NSMutableArray* queue =  [self.requests objectForKey:key];
            for (ZKResponse r in queue) {
                r(data,res,error);
            }
            [self.requests removeObjectForKey:key];
        }];
    }
}

@end
