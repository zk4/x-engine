//
//  KOHttp.m
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 x-engine. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE./

#import "KOHttp.h"

#ifdef DEBUG
#  define NSLog(fmt, ...) do {                                            \
NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
NSLog((@"%@(%d) " fmt), [file lastPathComponent], __LINE__, ##__VA_ARGS__); \
} while(0)
#else
# define NSLog(...);
#endif

NSString*  __globalUrlPrefix;
NSMutableDictionary<NSString*,NSMutableArray*>*  __ko_Pipelines;

@interface KOHttp()
@property (nonatomic, strong)   NSURLSession *session;
@property (atomic, strong)   NSMutableArray*  filters;
@property (nonatomic, assign)   int pos;
@end

@implementation KOHttp
+(NSMutableDictionary<NSString*,NSMutableArray*>*)  ko_globalPipelines{
    if(!__ko_Pipelines){
        __ko_Pipelines = [NSMutableDictionary new];
    }
    return __ko_Pipelines;
}
 
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

-(id<iKONetAgent>) addFilter:(id<iKOFilter>) filter{
    @synchronized (self) {
        if(!self.filters){
            self.filters=[NSMutableArray new];
        }
    }
    [self.filters addObject:filter];
    return self;
}

- (nonnull id<iKONetAgent>) activePipeline:(nonnull KOPipeline)pipeline {
    self.filters = pipeline;
    return self;
}

- (void) activePipelineByName:(NSString*) name {
    KOPipeline pipeline =  [KOHttp ko_globalPipelines][name];
    NSAssert(pipeline, @"没有 pipeline");
    
    if(pipeline){
        [self activePipeline:pipeline];
    }
}

- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)KOResponse chain:(nonnull id<iKOFilterChain>)chain {
  
    NSURLSessionDataTask *sessionTask = [self.session dataTaskWithRequest:request completionHandler:KOResponse];
    [sessionTask resume];
     
}

-(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(KOResponse) KOResponse{
    if(self.pos<self.filters.count){
        id<iKOFilter> filter =  [self.filters objectAtIndex:self.pos++];
        __weak typeof(self) weakSelf = self;
        [filter doFilter:session request:request  response:KOResponse chain:weakSelf];
    }else{
        __weak typeof(self) weakSelf = self;
        [self doFilter:session request:request response:KOResponse chain:weakSelf];
    }
}
+ (id)sharedSession
{
    static NSURLSession *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sharedInstance = [NSURLSession sessionWithConfiguration:configuration];
    });
    return sharedInstance;
}
 

 
 
-(id<iKONetAgent>) send:(NSMutableURLRequest*) request response:(KOResponse) block{
    self.session= [KOHttp sharedSession];
    [self doFilter:self.session request:request response:^(id _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data,response,error);
    }];
    return self;
}




- (nonnull NSString *)name {
    return @"I am the real networking!";
}

@end
