//
//  NSUserDefaults+Extension.h
//  ECEJ
//
//  Created by jia on 16/4/14.
//  Copyright © 2016年 ECEJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)

+ (BOOL)haveDataForKey:(NSString *)key;

+ (void)setStringObject:(NSString *)string forKey:(NSString *)key;
+ (NSString *)stringObjectForKey:(NSString *)key;

+ (void)setIntegerValue:(NSInteger)integerValue forKey:(NSString *)key;
+ (NSInteger)integerValueForKey:(NSString *)key;

+ (void)setBoolValue:(BOOL)boolValue forKey:(NSString *)key;
+ (BOOL)boolValueForKey:(NSString *)key;

@end
