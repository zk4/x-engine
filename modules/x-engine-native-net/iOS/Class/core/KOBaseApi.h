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
@class JSONModel;
@interface KOBaseApi : NSObject
    @property(nonatomic,strong) NSMutableURLRequest* network;
    @property (nonatomic,strong) NSString* localUrlPrefix;


    - (NSString*) getMethod;
    - (NSString*) getFinalUrl:(JSONModel*) dto;
    - (NSError *) errorWrapper:(NSError *) error  underlyingError:(NSError*) underlyingError;
    - (void) activePipelineByName:(NSString*) name;
    - (NSString*) getPipelineName;
    - (NSString*) getContentType;
    - (NSDictionary*) getHeaders;
    - (NSData*) getBody:(JSONModel*) dto;
@end

NS_ASSUME_NONNULL_END
