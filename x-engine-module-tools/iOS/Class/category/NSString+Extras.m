//
//  NSString+Extras.m
//  CarCare
//
//  Created by zhipeng he on 12-6-6.
//  Copyright (c) 2012年 北京信达通博移动科技有限公司. All rights reserved.
//

#import "NSString+Extras.h"

@implementation NSString (Extras_)

//md5编码
- (NSString*)md5HexDigest
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ] lowercaseString];

}


//判断是字符串是否是int类型
- (BOOL)isPureInt
{ 
    NSScanner* scan = [NSScanner scannerWithString:self]; 
    int val; 
    return [scan scanInt:&val] && [scan isAtEnd]; 
}

- (NSString *)isnull
{
    return self?self:@"";
}

-(NSString *)notRounding:( float )price afterPoint:( int )position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness: NO  raiseOnOverflow: NO  raiseOnUnderflow: NO  raiseOnDivideByZero: NO ];
    
    NSDecimalNumber *ouncesDecimal;
    
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return  [NSString stringWithFormat: @"%@" ,roundedOunces];
    
}

//- (NSInteger )getCurrentYear
//{
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
//    
//    NSInteger year = [dateComponent year];
//    
//    return year;
//}

// 根据日期判断周几
//- (NSString *)weekdayStringFromDateString:(NSString *)dateString
//{
//    NSString *totalDate = [NSString stringWithFormat:@"%ld-%@", (long)[self getCurrentYear], dateString];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSDate *date = [formatter dateFromString:totalDate];
//
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
//
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//
//    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/beijing"];
//
//    [calendar setTimeZone: timeZone];
//
//    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
//
//    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
//
//    return [weekdays objectAtIndex:theComponents.weekday];
//}



//base64加密
- (NSString *)base64EncodeString
{
    
    //1.先把字符串转换为二进制数据
    if (!self || [self isEqualToString:@""])
    {
        return nil;
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
   
    //2.对二进制数据进行base64编码，返回编码后的字符串
    
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
}

// 解密
-(NSString *)base64DecodeString

{
    
    //1.将base64编码后的字符串『解码』为二进制数据
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    
    
    
    //2.把二进制数据转换为字符串返回
    
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
}


@end
