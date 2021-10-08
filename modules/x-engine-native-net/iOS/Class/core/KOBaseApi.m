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
@property(nonatomic,strong) NSString* _localPipelineName;

@end
@implementation KOBaseApi


+ (void) ko_configGlobalUrlPrefix:(NSString*) urlPrefix {
    __globalUrlPrefix = urlPrefix;
}

+ (NSString*) ko_getGlobalUrlPrefix {
    return __globalUrlPrefix;
}

+ (void) ko_configPipelineByName:(NSString*) name pipeline:(KOPipeline) pipeline{
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


- (void) activePipelineByName:(NSString*) name{
    KOPipeline pipeline =  __ko_Pipelines[name];
    NSAssert(pipeline, @"没有 pipeline");
    
    if(pipeline){
        self._localPipelineName = name;
        [self.network activePipeline:pipeline];
    }
}

- (NSString*) getPipelineName{
    if(!self._localPipelineName){
        self._localPipelineName= @"DEFAULT";
    }
    return self._localPipelineName;
}



@end
