//
//  GlobalResStatusCodeNot2xxFilter.m
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

#import "GlobalResStatusCodeNot2xxFilter.h"
#import "XENativeContext.h"
#import "iToast.h"
@implementation GlobalResStatusCodeNot2xxFilter
+ (id)sharedInstance
{
    static GlobalResStatusCodeNot2xxFilter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)response chain:(id<iKOFilterChain>) chain {
    [chain doFilter:session request:request response:^(id _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSHTTPURLResponse* hres = (NSHTTPURLResponse*) res;
        if(!(hres.statusCode >= 200 && hres.statusCode < 300)){
#ifdef DEBUG
            NSString* msg =[NSString stringWithFormat:@"服务器状态码为 %ld, 当前不会回调到业务，开发人员请注意。\n%@\n%@\n%@" ,hres.statusCode, request.URL, request.allHTTPHeaderFields, request.HTTPBody];
            NSLog(@"%@",msg);
            [XENP(iToast) toast:msg];
#endif
            return;
        }else{
            response(data,res,error);
        }
    }];
}
- (nonnull NSString *)name {
    return @"全局非2xx 处理 filter";
}
@end
