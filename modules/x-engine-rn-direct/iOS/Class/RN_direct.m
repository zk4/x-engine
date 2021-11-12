//
//  RN_direct.m
//  direct
//
// Copyright (c) 2021 x-engine
// 

#import "RN_direct.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iDirectManager.h"
#import "JSI_direct.h"

@interface RN_direct()
@end

@implementation RN_direct
RCT_EXPORT_MODULE() ;

RCT_EXPORT_METHOD(push:(NSDictionary *)dict) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [XENP(iDirectManager) push:dict[@"scheme"] host:dict[@"host"] pathname:dict[@"pathname"] fragment:dict[@"fragment"] query:dict[@"query"] params:dict[@"params"]];
    });
}

RCT_EXPORT_METHOD(back:(NSDictionary *)dict) {
    dispatch_async(dispatch_get_main_queue(), ^{
        DirectBackDTO *dto = [[DirectBackDTO alloc] init];
        dto.scheme = dict[@"scheme"];
        dto.fragment = dict[@"fragment"];
        [XENP(iDirectManager) back:dto.scheme host:nil fragment:dto.fragment];
    });
}
@end

