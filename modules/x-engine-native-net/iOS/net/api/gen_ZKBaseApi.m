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
    self.network = [NSMutableURLRequest new];
    self.network.URL =[NSURL URLWithString:[self getUrl]];
    self.network.HTTPMethod = [self getMethod];
    self.network.HTTPBody = self.postReq.toJSONData;
    [self addLocalFilter:self.network];
    [self.network send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSError* err;
        id resPost = [[PostRes alloc] initWithDictionary:data error:&err];
        response(resPost,res,[XToolError wrapper:error underlyingError:err]);
    }];
}
#ifdef USING_GOOGLE_PROMISE

- (FBLPromise<PostRes *>*) promise:(PostReq*) postReq{
    FBLPromise<PostRes *>* promise = [FBLPromise async:^(FBLPromiseFulfillBlock fulfill, FBLPromiseRejectBlock reject) {
        self.network = [NSMutableURLRequest new];
        self.network.URL =[NSURL URLWithString:[self getUrl]];
        self.network.HTTPMethod = [self getMethod];
        self.network.HTTPBody = postReq.toJSONData;
        [self addLocalFilter:self.network];
        [self.network send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            if(!error){
                NSError* err;
                id resPost = [[PostRes alloc] initWithDictionary:data error:&err];
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

- (FBLPromise<PostRes *>*) promise{
    return [self promise:self.postReq];
}

#endif
@end
