//
//  XEAFNetworkUtil.m
//  network
//
//  Created by 吕冬剑 on 2020/9/24.
//  Copyright © 2020 edz. All rights reserved.
//

#import "XEAFNetwork4Util.h"
#import <AFNetworking.h>
#import "XEUploadDataModel.h"

@implementation XEAFNetwork4Util

+(instancetype)instance{
    static XEAFNetwork4Util *util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[XEAFNetwork4Util alloc] init];
    });
    return util;
}

-(void)requestAction:(NSString *)URLString
              method:(NSString *)method
          parameters:(nullable id)parameters
             headers:(nullable NSDictionary<NSString *,NSString *> *)headers
             success:(nullable void (^)(NSURLSessionDataTask *, id _Nullable))successBlock
             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError *))failBlock{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    if([headers[@"Content-Type"] rangeOfString:@"application/json"].location != NSNotFound){
        manage.requestSerializer = [AFJSONRequestSerializer serializer];
    }else{
        manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    if ([method isEqualToString:@"PUT"]){
        [manage PUT:URLString parameters:parameters headers:headers success:successBlock failure:failBlock];
    } else if ([method isEqualToString:@"DELETE"]){
        [manage DELETE:URLString parameters:parameters headers:headers success:successBlock failure:failBlock];
    } else if ([method isEqualToString:@"PATCH"]){
        [manage PATCH:URLString parameters:parameters headers:headers success:successBlock failure:failBlock];
    }else if ([method isEqualToString:@"HEAD"]){
        [manage HEAD:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask *task) {
            if(successBlock){
                successBlock(task, nil);
            }
        } failure:failBlock];
    } else if ([method isEqualToString:@"GET"]){
        [manage GET:URLString parameters:parameters headers:headers progress:nil success:successBlock failure:failBlock];
    } else {
        //默认POST
        [manage POST:URLString parameters:parameters headers:headers progress:nil success:successBlock failure:failBlock];
    }
}

- (NSURLSessionDownloadTask *_Nonnull)downloadTaskWithRequest:(NSURLRequest *_Nonnull)request
                                                     progress:(nullable void (^)(NSProgress *_Nonnull))downloadProgressBlock
                                                  destination:(nullable NSURL *_Nonnull(^)(NSURL *_Nonnull, NSURLResponse *_Nonnull))destination
                                            completionHandler:(nullable void (^)(NSURLResponse *_Nonnull, NSURL * _Nullable, NSError * _Nullable))completionHandler{
    return [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData progress:(void (^)(NSProgress *))uploadProgressBlock completionHandler:(void (^)(NSURLResponse *, id _Nullable, NSError * _Nullable))completionHandler{
    
    return [[AFHTTPSessionManager manager] uploadTaskWithRequest:request fromData:bodyData progress:uploadProgressBlock completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)upload:(NSString *)URLString
                      parameters:(nullable id)parameters
                         headers:(nullable NSDictionary<NSString *,NSString *> *)headers
                        dataList:(NSArray<XEUploadDataModel *> *)dataList
                        progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                         success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    return [[AFHTTPSessionManager manager] POST:URLString
                                     parameters:parameters
                                        headers:headers
                      constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (XEUploadDataModel *item in dataList) {
            
            @autoreleasepool {
                NSData *data = nil;
                if(item.fileBase64Str.length > 0){
                    NSRange range = [item.fileBase64Str rangeOfString:@"base64,"];
                    if(range.location != NSNotFound){
                        NSString *fileBase = [item.fileBase64Str substringFromIndex:range.location + range.length];
                        data = [[NSData alloc] initWithBase64EncodedString:fileBase options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    }else{
                        data = [[NSData alloc] initWithBase64EncodedString:item.fileBase64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    }
                } else {
                    
                }
                if(data == nil){
                    data = [NSData dataWithContentsOfFile:item.filePath];
                }
                if(data){
                    [formData appendPartWithFileData:data
                                                name:item.paramKey
                                            fileName:item.fileName
                                            mimeType:item.mimeType];
                }
            }
        }
    } progress:uploadProgress
                                        success:success
                                        failure:failure];
}
@end
