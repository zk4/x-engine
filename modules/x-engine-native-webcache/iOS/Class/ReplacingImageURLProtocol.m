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
static NSString* const Header_Content_Type=@"Content-Type";

@interface ReplacingImageURLProtocol()
 
@end


@implementation ReplacingImageURLProtocol

 
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
    id<iStore> cache= XENP(iStore);
    NSDictionary* data=  [cache get:[NSString stringWithFormat:@"%@%@",WebCacheKey,self.request.URL.absoluteString]];

    if(data){
        NSData* rawdata = (NSData*)data[@"data"];
        NSString* contenttype = data[@"headers"][Header_Content_Type];
        NSArray* tokens = [contenttype componentsSeparatedByString:@";"];
        NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:tokens[0] expectedContentLength:rawdata.length textEncodingName:nil];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
        [self.client URLProtocol:self didLoadData:rawdata];
        [self.client URLProtocolDidFinishLoading:self];
        NSLog(@"hit cache: ==========>%@",request.URL);

        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager
     GET:self.request.URL.absoluteString
     parameters: nil
     headers:self.request.allHTTPHeaderFields
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 准备数据
        NSData* data = responseObject;

        NSHTTPURLResponse* resp = (NSHTTPURLResponse*) task.response;
        [self.client URLProtocol:self didReceiveResponse:resp cacheStoragePolicy:NSURLCacheStorageAllowed];
        NSDictionary* headers =  resp.allHeaderFields;
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
        
        id<iStore> cache= XENP(iStore);
        /// TODO: 不缓存接口
        NSString* contenttype = headers[Header_Content_Type];
        NSArray* tokens = [contenttype componentsSeparatedByString:@";"];
        NSString* mimeType = tokens[0];
        BOOL shoudCache = [@[@"application/javascript"] indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [mimeType compare:obj options:NSCaseInsensitiveSearch] == NSOrderedSame;
        }] != NSNotFound;
        if(shoudCache){
            [cache set:[NSString stringWithFormat:@"%@%@",WebCacheKey,self.request.URL.absoluteString] val:@{@"data":data,@"headers":headers}];
            NSLog(@"save cache: ==========>%@",task.response.URL);
        }


    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"failed");
    }];
 
  
}
 
- (void) stopLoading{
    
}
@end
