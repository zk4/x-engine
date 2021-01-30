//
//  PublicData.m
//  ECEJ
//
//  Created by jia on 16/3/31.
//  Copyright © 2016年 ECEJ. All rights reserved.
//

#import "PublicData.h"

@interface PublicData ()

@end

@implementation PublicData

+ (instancetype)sharedInstance {
     static PublicData *sharedInstance = nil;
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           sharedInstance = [[PublicData alloc] init];
       });
       return sharedInstance;
} 
@end
