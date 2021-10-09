//
//  KOBaseApi.m
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import "KOBaseApi.h"
#import "JSONModel.h"
#import "KOHttp.h"
#import "NSURL+QueryDictionary.h"



@interface KOBaseApi()
@property(nonatomic,strong) NSString* _localPipelineName;

@end
@implementation KOBaseApi



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


- (void) activePipelineByName:(NSString*) name {
    KOPipeline pipeline =  [KOHttp ko_globalPipelines][name];
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

- (NSDictionary*) getHeaders{
    NSMutableDictionary* dict=  [NSMutableDictionary new];
    dict[@"Content-Type"]=[self getContentType];
    return  [dict copy];
}

- (NSData*) getBody:(JSONModel*) dto {
    if([[self getContentType] isEqualToString:@"application/json"])
        return  dto.toJSONData;
    else if([[self getContentType] isEqualToString:@"application/x-www-form-urlencoded"]){
       NSDictionary* d =  dto.toDictionary;
        
        if (!d || d.allKeys.count == 0) {
            return [NSData new];
        }
        // handle file
        for(NSString* str in d){
            if([str hasPrefix:@"file://"]){
                // TOOD convert file to 
            }
        }

       return [d.uq_URLQueryString dataUsingEncoding:NSUTF8StringEncoding];
    }
    else{
        NSAssert(nil, @"请覆盖此方法,怎么序列化参数到 body");
        return nil;
    }
}


@end
