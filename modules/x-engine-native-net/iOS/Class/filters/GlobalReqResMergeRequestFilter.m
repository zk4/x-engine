//
//  GlobalReqResMergeRequestFilter.m
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

#import "GlobalReqResMergeRequestFilter.h"
#import "XENativeContext.h"
#import "iToast.h"
#import <CommonCrypto/CommonDigest.h>

// 注意,使用此模块时,不能过早丢失请求
@interface GlobalReqResMergeRequestFilter()
@property (nonatomic, strong)   NSMutableDictionary<NSString*,NSMutableArray*>* requests;
@end
@implementation GlobalReqResMergeRequestFilter
+ (id)sharedInstance
{
    static GlobalReqResMergeRequestFilter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.requests = [NSMutableDictionary new];
    });
    return sharedInstance;
}
 
 


- (NSString *)md5:(NSData*)body {
    if(!body) return @"";
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
        
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(body.bytes, (unsigned int)body.length, md5Buffer);
        
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)response chain:(id<iKOFilterChain>) chain {
    
//    if(![request.HTTPMethod isEqualToString:@"GET"]){
//        [chain doFilter:session request:request response:response];
//        return;
//    }
    NSString* key = [NSString stringWithFormat:@"%@%@%@",request.HTTPMethod, request.URL.absoluteString, [self md5:request.HTTPBody] ];
    id queue =  [self.requests objectForKey:key];
    if(queue){
#ifdef DEBUG
        NSString* msg = [NSString stringWithFormat:@"请求过于频繁, 合并请求:%@:%@",request.HTTPMethod,request.URL.absoluteString];
        [XENP(iToast) toast:msg];
#endif
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
