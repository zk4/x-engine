//
//  NSString+Extras.h
//  CarCare
//
//  Created by zhipeng he on 12-6-6.
//  Copyright (c) 2012年 北京信达通博移动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Extras)

// base64加密 
-(NSString *)base64EncodeString;
// base64 解密
-(NSString *)base64DecodeString;
//md5编码
- (NSString*)md5HexDigest;

//判断是字符串是否是int类型
- (BOOL)isPureInt;

- (NSString *)isnull;

- (NSString *)descriptionWithLocale:(id)locale;
//只舍不入
-(NSString *)notRounding:( float )price afterPoint:( int )position;

// 根据日期判断周几
//- (NSString *)weekdayStringFromDateString:(NSString *)dateString;



@end
