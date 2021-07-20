//
//  NSCachedURLResponse+SetHeader.m
//  x-engine-native-jsi
//
//  Created by zk on 2021/7/21.
//

#import "NSCachedURLResponse+SetHeader.h"

@implementation NSCachedURLResponse (SetHeader)
-(NSCachedURLResponse*)cors:(NSString*) origin {
  NSCachedURLResponse* cachedResponse = self;
  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)[cachedResponse response];
  NSDictionary *headers = [httpResponse allHeaderFields];
  NSMutableDictionary* newHeaders = [headers mutableCopy];


    newHeaders[@"Access-Control-Allow-Origin"]  =origin;
    newHeaders[@"Access-Control-Allow-Credentials"]  =@"true";

     

  NSHTTPURLResponse* newResponse = [[NSHTTPURLResponse alloc] initWithURL:httpResponse.URL
                                                               statusCode:httpResponse.statusCode
                                                              HTTPVersion:@"HTTP/1.1"
                                                             headerFields:newHeaders];

  cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:newResponse
                                                            data:[cachedResponse.data mutableCopy]
                                                        userInfo:newHeaders
                                                   storagePolicy:cachedResponse.storagePolicy];
  return cachedResponse;
}
-(NSCachedURLResponse*)responseWithExpirationDuration:(int)duration {
  NSCachedURLResponse* cachedResponse = self;
  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)[cachedResponse response];
  NSDictionary *headers = [httpResponse allHeaderFields];
  NSMutableDictionary* newHeaders = [headers mutableCopy];

  newHeaders[@"Cache-Control"] = [NSString stringWithFormat:@"max-age=%i", duration];    
  [newHeaders removeObjectForKey:@"Expires"];
  [newHeaders removeObjectForKey:@"s-maxage"];
     

  NSHTTPURLResponse* newResponse = [[NSHTTPURLResponse alloc] initWithURL:httpResponse.URL
                                                               statusCode:httpResponse.statusCode
                                                              HTTPVersion:@"HTTP/1.1"
                                                             headerFields:newHeaders];

  cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:newResponse
                                                            data:[cachedResponse.data mutableCopy]
                                                        userInfo:newHeaders
                                                   storagePolicy:cachedResponse.storagePolicy];
  return cachedResponse;
}
@end
