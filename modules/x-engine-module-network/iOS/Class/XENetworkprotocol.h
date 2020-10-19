//
//  XENetWorkProtole.h
//  network
//
//  Created by 吕冬剑 on 2020/9/24.
//  Copyright © 2020 edz. All rights reserved.
//

@class XEUploadDataModel;
@protocol XENetworkprotocol <NSObject>

//发送请求
-(void)requestAction:(NSString *_Nonnull)URLString
              method:(NSString *_Nonnull)method
          parameters:(nullable id)parameters
             headers:(nullable NSDictionary<NSString *,NSString *> *)headers
             success:(nullable void (^)(NSURLSessionDataTask *_Nonnull, id _Nullable))successBlock
             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError *_Nullable))failBlock;

//下载文件
- (NSURLSessionDownloadTask *_Nonnull)downloadTaskWithRequest:(NSURLRequest *_Nonnull)request
                                                     progress:(nullable void (^)(NSProgress *_Nonnull))downloadProgressBlock
                                                  destination:(nullable NSURL *_Nonnull(^)(NSURL *_Nonnull, NSURLResponse *_Nonnull))destination
                                            completionHandler:(nullable void (^)(NSURLResponse *_Nonnull, NSURL * _Nullable, NSError * _Nullable))completionHandler;

//简易上传文件
- (NSURLSessionUploadTask *_Nonnull)uploadTaskWithRequest:(NSURLRequest *_Nonnull)request
                                                 fromData:(NSData *_Nullable)bodyData
                                                 progress:(nullable void (^)(NSProgress *_Nonnull))uploadProgressBlock
                                        completionHandler:(nullable void (^)(NSURLResponse *_Nullable, id _Nullable, NSError * _Nullable))completionHandler;

//复杂上传文件, 可以指定文件名, mimeType, 等
- (NSURLSessionDataTask *_Nonnull)upload:(NSString *_Nonnull)URLString
                              parameters:(nullable id)parameters
                                 headers:(nullable NSDictionary<NSString *,NSString *> *)headers
                                dataList:(NSArray<XEUploadDataModel *> *_Nonnull)dataList
                                progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                 success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

@end
