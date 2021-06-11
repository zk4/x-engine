//
//  ReplacingImageURLProtocol.m
//  NSURLProtocol+WebKitSupport
//
//  Created by yeatse on 2016/10/11.
//  Copyright © 2016年 Yeatse. All rights reserved.
//

#import "ReplacingImageURLProtocol.h"
#import "AFHTTPSessionManager.h"

#import <UIKit/UIKit.h>

static NSString* const FilteredKey = @"@@interceptable";

@implementation ReplacingImageURLProtocol

 
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString* extension = request.URL.pathExtension;
    BOOL interceptable = [@[@"js", @"css"] indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [extension compare:obj options:NSCaseInsensitiveSearch] == NSOrderedSame;
    }] != NSNotFound;
    return [NSURLProtocol propertyForKey:FilteredKey inRequest:request] == nil && interceptable;
//    NSLog(@"==========>%@",request.URL);
//    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSMutableURLRequest* request = self.request.mutableCopy;
    [NSURLProtocol setProperty:@YES forKey:FilteredKey inRequest:request];
    
    //1. 检测缓存
    //   1. 无: 请求网络
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager
     GET:self.request.URL.absoluteString
     parameters:nil
     headers:self.request.allHTTPHeaderFields
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 准备数据
        NSData* data = responseObject;
        // TODO: MIMEType 应该用原始的
        NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:@"application/*" expectedContentLength:data.length textEncodingName:nil];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];

    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"failed");
    }];
    //   2. 有: 返回缓存
    
  
}

- (void)stopLoading {
}

@end
