//
//  gen_ZKBaseApi.m
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import "gen_ZKBaseApi.h"
#import "XTool.h"


@implementation gen_ZKBaseApi

- (NSString*) getMethod{
    return @"POST";
}


- (NSString*) getUrl{
   return [NSString stringWithFormat:@"https://httpbin.org/post"];
}

- (void) request:(PostApiResponse) response{
    self.req = [NSMutableURLRequest new];
    self.req.URL =[NSURL URLWithString:[self getUrl]];
    self.req.HTTPMethod = [self getMethod];
    self.req.HTTPBody = self.postReq.toJSONData;
    [self addLocalFilter:self.req];
    [self.req send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSError* err;
        PostRes* resPost = [[PostRes alloc] initWithDictionary:data error:&err];
        response(resPost,res,[XToolError wrapper:error underlyingError:err]);
    }];
}
#ifdef USING_GOOGLE_PROMISE
- (FBLPromise<PostRes *>*) promise{
    FBLPromise<PostRes *>* promise = [FBLPromise async:^(FBLPromiseFulfillBlock fulfill, FBLPromiseRejectBlock reject) {
        self.req = [NSMutableURLRequest new];
        self.req.URL =[NSURL URLWithString:[self getUrl]];
        self.req.HTTPMethod = [self getMethod];
        self.req.HTTPBody = self.postReq.toJSONData;
        [self addLocalFilter:self.req];
        [self.req send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            if(!error){
                NSError* err;
                PostRes* resPost = [[PostRes alloc] initWithDictionary:data error:&err];
                if(!err)
                 fulfill(resPost);
                else
                    reject(err);
            }else{
                reject(error);
            }
        }];
    }];
    return promise;
}

#endif
@end
