//
//  gen_ZKBaseApi.m
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import "gen_ZKBaseApi.h"



@implementation gen_ZKBaseApi

- (NSString*) getMethod{
    return @"POST";
}
- (void) setPost:(Post*) arg{
    self.reqArg = arg;
}

- (NSString*) getUrl{
   return [NSString stringWithFormat:@"https://httpbin.org/post"];
}

- (void) request:(PostApiResponse) response{
    self.req = [NSMutableURLRequest new];
    self.req.URL =[NSURL URLWithString:[self getUrl]];
    self.req.HTTPMethod = [self getMethod];
    self.req.HTTPBody = self.reqArg.toJSONData;
    [self addLocalFilter:self.req];
    [self.req send:response];
}

@end
