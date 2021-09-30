//
//  gen_ZKBaseApi.h
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "xengine_dto_Post.h"
#import "ZKBaseApi.h"

#define USING_GOOGLE_PROMISE 1
#ifdef USING_GOOGLE_PROMISE
#import "FBLPromises.h"
#endif

NS_ASSUME_NONNULL_BEGIN

 
@interface gen_ZKBaseApi : ZKBaseApi

@property (nonatomic, strong) PostReq* postReq;
@property (nonatomic, strong) PostRes* postRes;

typedef void (^PostApiResponse)(PostRes* _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error);

- (void) setPostReq:(PostReq*) arg;
- (NSString*) getMethod;
- (void) request:(PostApiResponse) response;
#ifdef USING_GOOGLE_PROMISE
- (FBLPromise<PostRes *>*) promise;
#endif
@end

NS_ASSUME_NONNULL_END
