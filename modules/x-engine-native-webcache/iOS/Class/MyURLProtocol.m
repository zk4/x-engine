//
//  MyURLProtocol.m
//  x-engine-native-webcache
//
//  Created by zk on 2021/6/30.
//

#import "MyURLProtocol.h"



#define MyURLProtocolHandled @"MyURLProtocolHandled"



//创建archive数据模型，重写编码解码协议

@interface MyCacheData : NSObject



@property(nonatomic,strong) NSURLRequest *request;

@property(nonatomic,strong) NSURLResponse *response;

@property(nonatomic,strong) NSData *data;



@end



@interface NSURLRequest (MutableCopyWorkaround)



- (id)mutableCopyWorkaround;



@end



@interface MyURLProtocol ()



@property(nonatomic,strong) NSURLConnection *connection;

@property(nonatomic,strong) NSMutableData *httpData;

@property(nonatomic,strong) NSURLResponse *response;



@end



@implementation MyURLProtocol



#pragma mark - 重写NSURLProtocol子类方法



+ (BOOL)canInitWithRequest:(NSURLRequest *)request

{
    
    // 如果此请求是拦截到请求之后，接管请求而发起的新请求，则不处理。
    if (([request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"]) &&
        [request.HTTPMethod isEqualToString:@"get"] &&
        [request valueForHTTPHeaderField:MyURLProtocolHandled] == nil)
        
    {
        
        return YES;
        
    }
    // TODO: post body 丢失
    // https://github.com/li6185377/IMYWebLoader 这个方案也许可行
    if([request.HTTPMethod isEqualToString:@"post"]){
        NSLog(@"body is missing");
    }
    return NO;
    
}



+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request

{
    
    return request;
    
}



+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a

                       toRequest:(NSURLRequest *)b

{
    
    return [super requestIsCacheEquivalent:a toRequest:b];
    
}



- (void)startLoading

{
    
    //如果发现已经存在此请求的缓存数据，则返回缓存数据，否则发起新的请求从服务求加载数据
    
    MyCacheData *cacheData = [NSKeyedUnarchiver unarchiveObjectWithFile:
                              
                              [self cachePathForRequest:self.request]];
    
    if(cacheData != nil)
        
    {
        
        NSData *data = cacheData.data;
        
        NSURLResponse *response = cacheData.response;
        
        NSURLRequest *redirectRequest = cacheData.request;
        
        
        
        //使用NSURLProtocolClient做请求转向，直接将请求和数据转发到之前的请求
        
        if(redirectRequest != nil)
            
        {
            
            [[self client] URLProtocol:self wasRedirectedToRequest:redirectRequest
             
                      redirectResponse:response];
            
        }
        
        else
            
        {
            
            [[self client] URLProtocol:self didReceiveResponse:response
             
                    cacheStoragePolicy:NSURLCacheStorageNotAllowed];
            
            [[self client] URLProtocol:self didLoadData:data];
            
            [[self client] URLProtocolDidFinishLoading:self];
            
        }
        
    }
    
    else
        
    {
        
        //接管此网络请求，发起一个新的请求，后续会将新请求拿到的数据交给之前的旧请求
        
        NSMutableURLRequest *connectionRequest = [[self request] mutableCopyWorkaround];
        
        //增加标记，标示是由我们接管而发出的请求
        
        [connectionRequest setValue:@"Tag" forHTTPHeaderField:MyURLProtocolHandled];
        
        self.connection = [NSURLConnection connectionWithRequest:connectionRequest
                           
                                                        delegate:self];
        
    }
    
}



- (void)stopLoading

{
    
    [self.connection cancel];
    
    self.connection = nil;
    
}



#pragma mark - 网络请求代理



- (NSURLRequest *)connection:(NSURLConnection *)connection

             willSendRequest:(NSURLRequest *)request

            redirectResponse:(NSURLResponse *)response

{
    
    if(response != nil)
        
    {
        
        NSMutableURLRequest *redirectableRequest = [request mutableCopyWorkaround];
        
        
        
        //缓存数据
        
        MyCacheData *cacheData = [MyCacheData new];
        
        [cacheData setData:self.httpData];
        
        [cacheData setResponse:response];
        
        [cacheData setRequest:redirectableRequest];
        
        
        
        [NSKeyedArchiver archiveRootObject:cacheData
         
                                    toFile:[self cachePathForRequest:[self request]]];
        
        
        
        //将请求和缓存的响应数据转向到之前的请求
        
        [[self client] URLProtocol:self wasRedirectedToRequest:redirectableRequest
         
                  redirectResponse:response];
        
        return redirectableRequest ;
        
    }
    
    return request;
    
}



- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection

{
    
    return YES;
    
}



- (void)connection:(NSURLConnection *)connection

didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge

{
    
    [self.client URLProtocol:self didReceiveAuthenticationChallenge:challenge];
    
}



- (void)connection:(NSURLConnection *)connection

didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge

{
    
    [self.client URLProtocol:self didCancelAuthenticationChallenge:challenge];
    
}



- (void)connection:(NSURLConnection *)connection

didReceiveResponse:(NSURLResponse *)response

{
    
    //保存响应对象
    
    self.response = response;
    
    [self.client URLProtocol:self didReceiveResponse:response
     
          cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    
}



- (void)connection:(NSURLConnection *)connection

    didReceiveData:(NSData *)data

{
    
    [self.client URLProtocol:self didLoadData:data];
    
    
    
    //保存服务器返回的数据
    
    if(self.httpData == nil) {
        
        self.httpData = [NSMutableData dataWithData: data];
        
    }
    
    else
        
    {
        
        [self.httpData appendData:data];
        
    }
    
}



- (NSCachedURLResponse *)connection:(NSURLConnection *)connection

                  willCacheResponse:(NSCachedURLResponse *)cachedResponse

{
    
    return cachedResponse;
    
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    
    [self.client URLProtocolDidFinishLoading:self];
    
    
    
    //请求加载完毕之后，将数据缓存
    
    MyCacheData *cacheData = [MyCacheData new];
    
    [cacheData setData:self.httpData];
    
    [cacheData setResponse:self.response];
    
    [NSKeyedArchiver archiveRootObject:cacheData
     
                                toFile:[self cachePathForRequest:self.request]];
    
    
    
    self.connection = nil;
    
    self.httpData = nil;
    
    self.response = nil;
    
}



- (void)connection:(NSURLConnection *)connection

  didFailWithError:(NSError *)error

{
    
    [self.client URLProtocol:self didFailWithError:error];
    
    
    
    self.connection = nil;
    
    self.httpData = nil;
    
    self.response = nil;
    
}



#pragma mark - 为请求创建缓存路径



- (NSString *)cachePathForRequest:(NSURLRequest *)aRequest

{
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                                
                                                                NSUserDomainMask, YES) lastObject];
    
    return [cachesPath stringByAppendingPathComponent:
            
            [NSString stringWithFormat:@"%ld", [[[aRequest URL] absoluteString] hash]]];
    
}



@end



@implementation NSURLRequest (MutableCopyWorkaround)



- (id) mutableCopyWorkaround {
    
    NSMutableURLRequest *mutableURLRequest = [[NSMutableURLRequest alloc]
                                              
                                              initWithURL:[self URL]
                                              
                                              cachePolicy:[self cachePolicy]
                                              
                                              timeoutInterval:[self timeoutInterval]];
    
    [mutableURLRequest setAllHTTPHeaderFields:[self allHTTPHeaderFields]];
    
    return mutableURLRequest;
    
}



@end



@implementation MyCacheData



-(id) initWithCoder:(NSCoder *) aDecoder

{
    
    self = [super init];
    
    if(!self) {
        
        return nil;
        
    }
    
    [self setData:[aDecoder decodeObjectForKey:@"data"]];
    
    [self setRequest:[aDecoder decodeObjectForKey:@"request"]];
    
    [self setResponse:[aDecoder decodeObjectForKey:@"response"]];
    
    
    
    return self;
    
}



- (void)encodeWithCoder:(NSCoder *)aCoder

{
    
    [aCoder encodeObject:[self data] forKey:@"data"];
    
    [aCoder encodeObject:[self request] forKey:@"request"];
    
    [aCoder encodeObject:[self response] forKey:@"response"];
    
}



@end

