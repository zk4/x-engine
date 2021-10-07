//
//  KOBaseApi.m
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import "KOBaseApi.h"
NSString*  __globalUrlPrefix;
NSMutableDictionary<NSString*,NSMutableArray*>*  __ko_Pipelines;

@interface KOBaseApi()
@end
@implementation KOBaseApi

+ (void) configGlobalFiltersWithNetwork:(GlobalFilterConfiger) config{
    __globalFiltersConfig=config;
}
+ (void) configGlobalUrlPrefix:(NSString*) urlPrefix{
    __globalUrlPrefix = urlPrefix;
}
+ (void) configPipelineByName:(NSString*) name pipeline:(KOPipeline) pipeline{
    if(!__ko_Pipelines){
        __ko_Pipelines = [NSMutableDictionary new];
    }
    __ko_Pipelines[name] =  pipeline;
}

- (instancetype)init {
    if (self = [super init]) {
        self.network = [NSMutableURLRequest new];
    }
    return self;
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

- (void) activeGlobalFilters{
    __globalFiltersConfig(self.network);
}
- (void) activePipeline:(NSString*) name{
    KOPipeline pipeline =  __ko_Pipelines[name];
    NSAssert(pipeline, @"没有 pipeline");
    if(pipeline){
        [self.network activePipeline:pipeline];
    }
}
@end
