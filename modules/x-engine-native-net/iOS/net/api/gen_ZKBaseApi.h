//
//  gen_ZKBaseApi.h
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "xengine_jsi_undefined.h"
#import "ZKBaseApi.h"

#define USING_GOOGLE_PROMISE 1
#ifdef USING_GOOGLE_PROMISE
#import "FBLPromises.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@class Post;
@interface gen_ZKBaseApi : ZKBaseApi

@property (nonatomic, strong) Post* reqArg;

typedef void (^PostApiResponse)(Post* _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error);

- (void) setPost:(Post*) arg;
- (NSString*) getMethod;
- (void) request:(PostApiResponse) response;
#ifdef USING_GOOGLE_PROMISE
- (FBLPromise<Post *>*) promise;
#endif
@end

NS_ASSUME_NONNULL_END
