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

    + (void) ko_configGlobalUrlPrefix:(NSString*) urlPrefix;
    + (NSString*) ko_getGlobalUrlPrefix;

    // 绑定 pipelineName 与 pipeline
    // 使用 activePipeline 方法激活
    + (void) ko_configPipelineByName:(NSString*) name pipeline:(KOPipeline) pipeline;

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
