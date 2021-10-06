//
//  KOBaseApi.h
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

extern NSString*  __globalUrlPrefix;

@interface KOBaseApi : NSObject
    @property(nonatomic,strong) NSMutableURLRequest* network;
    @property (nonatomic,strong) NSString* localUrlPrefix;
    // 主要是用来切换全局环境用，之所以不使用 baseurl，是因为，环境不一定是只有 scheme 和 host， 有可能带有一点 path。
    + (void) configGlobalUrlPrefix:(NSString*) urlPrefix;
    + (void) configGlobalFiltersWithNetwork:(GlobalFilterConfiger) config;
    - (NSString*) getMethod;
    - (void) addFiltersWithNetwork:(NSMutableURLRequest*) network;
    - (NSString*) getFinalUrl;
    -(NSError *) errorWrapper:(NSError *) error  underlyingError:(NSError*) underlyingError;
@end

NS_ASSUME_NONNULL_END
