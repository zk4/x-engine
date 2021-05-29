//
//  Native_rest.h
//  rest
//
//  Copyright © 2020 @zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XENativeModule.h"

NS_ASSUME_NONNULL_BEGIN

@class AFHTTPSessionManager;

@protocol iRest
- (AFHTTPSessionManager *)session:(NSURL *)baseUrl;
    
//   
//- (NSURLSessionDataTask *)GET:(NSString *)URLString
//                   parameters:(nullable id)parameters
//                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
//                     progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress
//                      success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
//                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;
//    
//   
//
//- (NSURLSessionDataTask *)HEAD:(NSString *)URLString
//                    parameters:(nullable id)parameters
//                       headers:(nullable NSDictionary<NSString *,NSString *> *)headers
//                       success:(nullable void (^)(NSURLSessionDataTask * _Nonnull))success
//                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;
//
//- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
//                             parameters:(nullable id)parameters
//                                headers:(nullable NSDictionary <NSString *, NSString *> *)headers
//                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
//                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
//                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
//
//
//- (NSURLSessionDataTask *)PUT:(NSString *)URLString
//                   parameters:(nullable id)parameters
//                      headers:(nullable NSDictionary<NSString *,NSString *> *)headers
//                      success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
//                      failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;
//
//- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
//                     parameters:(nullable id)parameters
//                        headers:(nullable NSDictionary<NSString *,NSString *> *)headers
//                        success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
//                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;
//
//- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
//                      parameters:(nullable id)parameters
//                         headers:(nullable NSDictionary<NSString *,NSString *> *)headers
//                         success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
//                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;
//
//
//- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
//                                       URLString:(NSString *)URLString
//                                      parameters:(nullable id)parameters
//                                         headers:(nullable NSDictionary <NSString *, NSString *> *)headers
//                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
//                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
//                                         success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
//                                         failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
//

@end

NS_ASSUME_NONNULL_END
