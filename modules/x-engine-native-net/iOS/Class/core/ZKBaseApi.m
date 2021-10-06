//
//  ZKBaseApi.m
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import "ZKBaseApi.h"
NSString*  __globalSchemaHost;

@implementation ZKBaseApi
+ (void) configGlobalFiltersWithNetwork:(GlobalFilterConfiger) config{
    __globalFiltersConfig=config;
}
+ (void) configSchemaHost:(NSString*) schemaHost{
    __globalSchemaHost = schemaHost;
}
-(NSError *) errorWrapper:(NSError *) error  underlyingError:(NSError*) underlyingError{
  if (!error) {
      return underlyingError;
  }
  if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
      return error;
  }
  NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
  mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
  return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

- (void) addFiltersWithNetwork:(NSMutableURLRequest*) network{
    __globalFiltersConfig(network);
}
@end
