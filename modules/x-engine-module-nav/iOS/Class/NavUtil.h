//
//  NavUtil.h
//  nav
//
//  Created by 吕冬剑 on 2020/9/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavUtil : NSObject

+ (UIImage *)getImageWithColor:(UIColor *)color andHeight:(CGFloat)height;

+ (CGSize )getIconSize:(NSArray * )iconSizeArray;

//根据文字计算宽度
+ (CGFloat)calculateRowWidth:(NSString *)string withFont:(NSString *)font;

//获取文件名
+ (NSString *)localFile:(NSString *)pathName ;

+ (UIImage *)setImageSize:(CGSize)size image:(UIImage *)image ;

//获取图片
+ (UIImage *)getOrignalImage:(NSString *)path;

//判断字符串
+ (BOOL)getNoEmptyString:(NSString *)sting;

@end
