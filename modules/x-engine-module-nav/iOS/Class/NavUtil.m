//
//  NavUtil.m
//  nav
//
//  Created by 吕冬剑 on 2020/9/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import "NavUtil.h"
#import "micros.h"
#import <MicroAppLoader.h>

@implementation NavUtil


//获取背景图片
+(UIImage *)getImageWithColor:(UIColor *)color andHeight:(CGFloat)height{
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(CGSize )getIconSize:(NSArray * )iconSizeArray{
    CGSize iconSize;
    CGFloat width = 30.0;
    CGFloat height = NAVIGATION_BAR_HEIGHT;
    if (iconSizeArray && [iconSizeArray isKindOfClass:NSArray.class]){
        if (iconSizeArray.count == 2) {
            NSString *widthStr = [NSString stringWithFormat:@"%@",iconSizeArray[0]];
            width = widthStr.floatValue;
            NSString *heighthStr = [NSString stringWithFormat:@"%@",iconSizeArray[1]];
            height = heighthStr.floatValue;
        }
    }
    iconSize = CGSizeMake(width, height);
    return iconSize;
}

//根据文字计算宽度
+(CGFloat)calculateRowWidth:(NSString *)string withFont:(NSString *)font{
    NSDictionary* dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font.floatValue]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

//获取文件名
+(NSString *)localFile:(NSString *)pathName {
    
    if([MicroAppLoader sharedInstance].nowMicroAppVersion > 0){
        NSString *path = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:[MicroAppLoader sharedInstance].nowMicroAppId
                                                                          in_version:[MicroAppLoader sharedInstance].nowMicroAppVersion];
        
        path = [NSString stringWithFormat:@"%@%@%@", path, [pathName hasPrefix:@"/"] ? @"" : @"/", pathName];
        return path;
    }else{
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
        NSString *fileName;
        NSString *R ;
        while (fileName = [dirEnum nextObject]) {
            if ([fileName hasSuffix:pathName]) {
                R = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
            }
        }
        return R;
    }
}


+ (UIImage *)setImageSize:(CGSize)size image:(UIImage *)image {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    return scaledImage;
}

//获取图片
+ (UIImage *)getOrignalImage:(NSString *)path {
    UIImage * image;
   if ([path hasPrefix:@"http"]) {
      NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
      image = [UIImage imageWithData:data];
   }else{
       
       NSString * pathName = [NavUtil localFile:path];
       image = [UIImage imageWithContentsOfFile:pathName];
   }
    return image;
}

//判断字符串
+ (BOOL)getNoEmptyString:(NSString *)sting{
    if ( [sting isKindOfClass:[NSString class]]
        && (sting.length > 0)
        && ![sting isEqualToString:@"(null)"]
        && ![sting isEqualToString:@"null"] ){
        return YES;
    }
    return NO;
}

@end
