//
//  NSString+GZBase.h
//  Appc
//
//  Created by 吕冬剑 on 2021/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GZBase)

+ (NSString *)getTimeStrWithString:(NSString *)str;

+ (NSString*)weekdayStringFromDate:(NSString *)timeString;

@end

NS_ASSUME_NONNULL_END
