//
//  ZKBaseApi.h
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableURLRequest+Filter.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^GlobalFilterConfiger)(NSMutableURLRequest*  request);
static GlobalFilterConfiger __globalFiltersConfig;
extern NSString*  __globalSchemaHost;
@interface ZKBaseApi : NSObject
    @property(nonatomic,strong) NSMutableURLRequest* network;
    + (void) configSchemaHost:(NSString*) schemaHost;
    + (void) configGlobalFiltersWithNetwork:(GlobalFilterConfiger) config;
    - (NSString*) getMethod;
    - (void) addFiltersWithNetwork:(NSMutableURLRequest*) network;
    - (NSString*) getUrl;
    -(NSError *) errorWrapper:(NSError *) error  underlyingError:(NSError*) underlyingError;
@end

NS_ASSUME_NONNULL_END
