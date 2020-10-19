//
//  XEngineNavModel.m
//  AFNetworking
//
//  Created by edz on 2020/7/24.
//

#import "XEngineNavModel.h"

@implementation XEngineNavModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"param_id": @"param.id", @"param_target": @"param.target"}];
}

@end
