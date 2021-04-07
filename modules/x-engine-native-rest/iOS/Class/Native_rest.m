//
//  Native_rest.m
//  rest
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_rest.h"
#import "NativeContext.h"
#import "AFHTTPSessionManager.h"

@interface Native_rest()
    @property (readwrite, nonatomic, strong) NSMutableDictionary<NSURL*, AFHTTPSessionManager*> *sessionManagers;

@end

@implementation Native_rest
NATIVE_MODULE(Native_rest)

 - (NSString*) moduleId{
    return @"com.zkty.native.rest";
}

- (int) order{
    return 0;
}
- (instancetype)init
{
    self = [super init];
    if(self){
        self.sessionManagers = [NSMutableDictionary new];
    }
    return self;
}


- (void)afterAllNativeModuleInited{
} 
 
- (AFHTTPSessionManager *)session:(NSURL *)baseUrl{
 
//    if(!url.host)
//        @throw [NSException exceptionWithName:@"NO HOST" reason:@"没 host" userInfo:nil];
    
    AFHTTPSessionManager* sessionManager = [self.sessionManagers objectForKey:baseUrl];

    /// TODO: 同步
    if(!sessionManager){
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        [self.sessionManagers setObject:sessionManager forKey:baseUrl];
    }
    return sessionManager;
}
//- (nonnull NSURLSessionDataTask *)DELETE:(nonnull NSString *)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *,NSString *> *)headers success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(nullable void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure {
//    NSURL * url = [NSURL URLWithString:URLString];
//    if(!url.host)
//        @throw [NSException exceptionWithName:@"NO HOST" reason:@"没 host" userInfo:nil];
//    AFHTTPSessionManager* sessionManager = [self.sessionManagers objectForKey:url.baseURL];
//
//    /// TODO: 同步
//    if(!sessionManager){
//        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url.baseURL];
//        [self.sessionManagers setObject:sessionManager forKey:url.baseURL];
//    }
//    return [sessionManager DELETE:url.path parameters:parameters headers:headers success:success failure:failure];
//}
//

@end
 
