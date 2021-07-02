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


/*
 @method canInitWithRequest:
 该方法确定该协议是否可以处理给定的请求。一个具体的子类应该检查给定的请求和确定实现是否可以执行与该请求。这是一个抽象的方法。分包必须提供一个实现。
 @param request检查请求。
 @result如果协议能够处理给定的请求，则为YES，如果不能，则为NO。
 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    //    NSString* extension = request.URL.pathExtension;
    //    BOOL interceptable = [@[@"js", @"css", @"png",@"jpg",@"jpeg",@"gif"] indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        return [extension compare:obj options:NSCaseInsensitiveSearch] == NSOrderedSame;
    //    }] != NSNotFound;
    //    BOOL stop = interceptable && [@"GET" isEqualToString:request.HTTPMethod];
    //
    //    NSLog(@"%@ ==========>%@",stop?@"STOP":@"PASS",request.URL);
    //
    //    return stop;
    
    NSLog(@"%@", request);
    
    return YES;
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
    NSDictionary* data=  [cache get:[NSString stringWithFormat:@"%@%@",WebCacheKey,self.request.URL.absoluteString]];
    
    if(data){
        NSData* rawdata = (NSData*)data[@"data"];
        NSString* contenttype = data[@"headers"][@"Content-Type"];
        NSArray* tokens = [contenttype componentsSeparatedByString:@";"];
        NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:tokens[0] expectedContentLength:rawdata.length textEncodingName:nil];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
        [self.client URLProtocol:self didLoadData:rawdata];
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
        
        //        NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:@"application/*" expectedContentLength:data.length textEncodingName:nil];
        
        NSHTTPURLResponse* resp = (NSHTTPURLResponse*) task.response;
        [self.client URLProtocol:self didReceiveResponse:resp cacheStoragePolicy:NSURLCacheStorageAllowed];
        NSDictionary* headers =  resp.allHeaderFields;
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
        id<iStore> cache= XENP(iStore);
        [cache set:[NSString stringWithFormat:@"%@%@",WebCacheKey,self.request.URL.absoluteString] val:@{@"data":data,@"headers":headers}];
        NSLog(@"save cache: ==========>%@",task.response.URL);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"failed");
    }];
    
    
}

- (void)stopLoading {
}

@end
