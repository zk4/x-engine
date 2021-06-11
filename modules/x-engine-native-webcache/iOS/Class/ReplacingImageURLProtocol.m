//
//  ReplacingImageURLProtocol.m
//  NSURLProtocol+WebKitSupport
//
//  Created by yeatse on 2016/10/11.
//  Copyright © 2016年 Yeatse. All rights reserved.
//

#import "ReplacingImageURLProtocol.h"
#import "AFHTTPSessionManager.h"
#import "iStore.h"
#import "XENativeContext.h"
#import <UIKit/UIKit.h>
#import "micros.h"

static NSString* const FilteredKey = @"@@interceptable";
static NSString* const WebCacheKey = @"@@WebGetCache";


@interface ReplacingImageURLProtocol()
 
@end


@implementation ReplacingImageURLProtocol

 
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString* extension = request.URL.pathExtension;
    BOOL interceptable = [@[@"js", @"css",@"html",@"png",@"jpg",@"jpeg",@"gif"] indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [extension compare:obj options:NSCaseInsensitiveSearch] == NSOrderedSame;
    }] != NSNotFound;
    BOOL stop = interceptable && [@"GET" isEqualToString:request.HTTPMethod];

    NSLog(@"%@ ==========>%@",stop?@"STOP":@"PASS",request.URL);

    return stop;

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

    id<iStore> cache= XENP(iStore);
    NSData* data=  [cache get:[NSString stringWithFormat:@"%@%@",WebCacheKey,self.request.URL.absoluteString]];
    if(data){
        NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:@"application/*" expectedContentLength:data.length textEncodingName:nil];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
        NSLog(@"hit cache: ==========>%@",request.URL);

        return;
    }
    // TODO: 应该带上所有原始请求信息
    [manager
     GET:self.request.URL.absoluteString
     parameters: nil
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
        id<iStore> cache= XENP(iStore);
        [cache set:[NSString stringWithFormat:@"%@%@",WebCacheKey,self.request.URL.absoluteString] val:data];

    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"failed");
    }];
    //   2. 有: 返回缓存
    
  
}

- (void)stopLoading {
}

@end
