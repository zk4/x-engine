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
    if ([NSURLProtocol propertyForKey:FilteredKey inRequest:request]) {
        return NO;
    }
    
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
-(NSString*) genCacheKey:(NSString*)key{
    return [NSString stringWithFormat:@"%@%@",WebCacheKey,key];
}

-(BOOL) shouldCache:(NSString*)mimeType{
    if(!mimeType)return NO;
    // TODO: 使用正则表达式更好点？
    NSArray* notCacheArray=@[@"application/json",@"video/mp4"];
    return [notCacheArray indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [mimeType compare:obj options:NSCaseInsensitiveSearch] == NSOrderedSame;
    }] == NSNotFound;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}


- (void)sendCache:(NSString *)mimeType rawdata:(NSData *)rawdata request:(NSMutableURLRequest *)request headers:(NSDictionary*)headers {
    NSHTTPURLResponse* response = [[NSHTTPURLResponse alloc] initWithURL:self.request.URL MIMEType:mimeType expectedContentLength:rawdata.length textEncodingName:nil];
    /// TODO: 怎么返回原始的 headers？
    //    response.allHeaderFields= headers.mutableCopy;
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    [self.client URLProtocol:self didLoadData:rawdata];
    [self.client URLProtocolDidFinishLoading:self];
    NSLog(@"hit cache: ==========>%@",request.URL);
}

- (NSString *)extractMimeType:(NSDictionary *)headers {
    NSString* contenttype = headers[Header_Content_Type];
    
    NSArray* tokens = contenttype?[contenttype componentsSeparatedByString:@";"]:nil;
    
    NSString* mimeType = (tokens && tokens.count)>0?tokens[0]:nil;
    return mimeType;
}

- (void)startLoading {
    NSString* url =self.request.URL.absoluteString;
    NSMutableURLRequest* request = self.request.mutableCopy;
    [NSURLProtocol setProperty:@YES forKey:FilteredKey inRequest:request];
    
    //1. 检测缓存
    id<iStore> store= XENP(iStore);
    NSDictionary* cache=  [store get:[self genCacheKey:url]];
    
    // 有缓存，直接用缓存
    if(cache){
        NSData* rawdata = (NSData*)cache[@"data"];
        NSDictionary* headers = cache[@"headers"];
        NSString* mimeType = [self extractMimeType:headers];
        /// TODO: default mimeType?
        [self sendCache:mimeType rawdata:rawdata request:request headers:headers];
    }
    //　使用rolling cache　机制，还要继续请求
    
    // 异步拿最新的数据
    NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc]initWithURL:self.request.URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLProtocol setProperty:@YES forKey:FilteredKey inRequest:request2];
    /// TODO: 视频不能用。
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        /// TODO: 视频会多次返回？
        if (connectionError == nil) {
            NSHTTPURLResponse* resp =(NSHTTPURLResponse* )response;
            NSDictionary* headers =  resp.allHeaderFields;
            NSString* mimeType = [self extractMimeType:headers];
            
            /// 无缓存，　怎么着也得返回一下。
            if(!cache){
                NSData* rawdata =data;
                /// TODO: default mimeType?
                [self sendCache:mimeType rawdata:rawdata request:request headers:headers];
            }
            /// 更新缓存
            if([self shouldCache:mimeType]){
                id<iStore> store= XENP(iStore);
                [store set:[self genCacheKey:self.request.URL.absoluteString] val:@{@"data":data,@"headers":headers}];
                NSLog(@"save cache: ==========>%@",resp.URL);
            }
            
        }else {
            NSLog(@"%@",connectionError);
        }
    }];
    
    
    
}

- (void) stopLoading{
    
}
@end
