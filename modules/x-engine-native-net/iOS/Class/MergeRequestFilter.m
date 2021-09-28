//
//  MergeRequestFilter.m
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import "MergeRequestFilter.h"

@implementation MergeRequestFilter

- (instancetype)init {
    if (self = [super init]) {
        self.requests=[NSMutableDictionary new];
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
        [chain doFilter:session request:request response:^(NSData * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            NSMutableArray* queue =  [self.requests objectForKey:key];
            for (ZKResponse r in queue) {
                r(data,res,error);
            }
            [self.requests removeObjectForKey:key];
        }];
    }
}

@end
