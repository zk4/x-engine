//
//  NavUtil.m
//  nav
//
//  Created by 吕冬剑 on 2020/9/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import "NavUtil.h"
#import "Unity.h"
#import "micros.h"

@implementation NavUtil

+ (void)setNavTitle:(NSString *)title withTitleColor:(NSString *)color withTitleSize:(NSInteger)size {
    

    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    topVC.title = title;
    UIColor *rgbColor;
    if (color && 0 != color.length ){
        rgbColor = [NavUtil colorFromHexCode:color];
    }
    if (rgbColor == nil){
        rgbColor = [UIColor blackColor];
    }
    float fontSize = size;
    NSDictionary *dic = @{
        NSForegroundColorAttributeName:rgbColor,
        NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
    };
    [topVC.navigationController.navigationBar setTitleTextAttributes:dic];

}

+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                        [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                        [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                        [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
  

 

@end
