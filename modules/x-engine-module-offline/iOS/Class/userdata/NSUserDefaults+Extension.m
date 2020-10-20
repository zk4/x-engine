//
//  NSUserDefaults+Extension.m
//  ECEJ
//
//  Created by jia on 16/4/14.
//  Copyright © 2016年 ECEJ. All rights reserved.
//

#import "NSUserDefaults+Extension.h"

@implementation NSUserDefaults (Extension)

+ (BOOL)haveDataForKey:(NSString *)key
{
    return ([[NSUserDefaults standardUserDefaults] objectForKey:key] ? YES : NO);
}

+ (void)setStringObject:(NSString *)string forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)stringObjectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)setIntegerValue:(NSInteger)integerValue forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setInteger:integerValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)integerValueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (void)setBoolValue:(BOOL)boolValue forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)boolValueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
