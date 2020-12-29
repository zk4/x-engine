//
//  xengine_protocol_network.h
//  Pods

#ifndef xengine_protocol_network_h
#define xengine_protocol_network_h
#include <Foundation/Foundation.h>


@class NSURLSessionDataTask, NSURLSessionUploadTask;
@protocol xengine_protocol_network <NSObject>

- (void)GET:(NSString *_Nonnull)URLString
 parameters:(nullable id)parameters
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
   progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

- (void)POST:(NSString *_Nonnull)URLString
  parameters:(nullable id)parameters
     headers:(nullable NSDictionary <NSString *, NSString *> *)headers
    progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
     success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

- (NSURLSessionDownloadTask*_Nonnull)downloadTaskWithRequest:(NSURLRequest *_Nonnull)request
                                            progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgressBlock
                                                 destination:(nullable NSURL * _Nullable (^)(NSURL * _Nullable targetPath, NSURLResponse * _Nullable response))destination
                                   completionHandler:(nullable void (^)(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler;

- (void)HEAD:(NSString *_Nonnull)URLString
  parameters:(nullable id)parameters
     headers:(nullable NSDictionary <NSString *, NSString *> *)headers
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;


- (void)PUT:(NSString *_Nullable)URLString
 parameters:(nullable id)parameters
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

- (void)PATCH:(NSString * _Nullable)URLString
   parameters:(nullable id)parameters
      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

- (void)DELETE:(NSString * _Nullable)URLString
    parameters:(nullable id)parameters
       headers:(nullable NSDictionary <NSString *, NSString *> *)headers
       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

- (void)uploadTaskWithRequest:(NSURLRequest * _Nullable)request
                     fromData:(nullable NSData *)bodyData
                     progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgressBlock
            completionHandler:(nullable void (^)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nullable error))completionHandler;
@end

#endif
