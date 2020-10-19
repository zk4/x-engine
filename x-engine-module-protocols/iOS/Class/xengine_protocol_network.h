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
                                                 destination:(nullable NSURL * _Nullable (^)(NSURL *targetPath, NSURLResponse * _Nullable response))destination
                                   completionHandler:(nullable void (^)(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler;

- (void)HEAD:(NSString *)URLString
  parameters:(nullable id)parameters
     headers:(nullable NSDictionary <NSString *, NSString *> *)headers
     success:(nullable void (^)(NSURLSessionDataTask *task))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;


- (void)PUT:(NSString *)URLString
 parameters:(nullable id)parameters
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
    success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

- (void)PATCH:(NSString *)URLString
   parameters:(nullable id)parameters
      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
      success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

- (void)DELETE:(NSString *)URLString
    parameters:(nullable id)parameters
       headers:(nullable NSDictionary <NSString *, NSString *> *)headers
       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

- (void)uploadTaskWithRequest:(NSURLRequest *)request
                     fromData:(nullable NSData *)bodyData
                     progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
            completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError * _Nullable error))completionHandler;
@end

#endif
