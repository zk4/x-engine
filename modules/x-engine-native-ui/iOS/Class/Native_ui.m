//
//  Native_ui.m
//  ui
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_ui.h"
#import "NativeContext.h"
#import "Unity.h"

@interface Native_ui()
{ }
@end

@implementation Native_ui
NATIVE_MODULE(Native_ui)

 - (NSString*) moduleId{
    return @"com.zkty.native.ui";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
}


- (void)setNavBarHidden:(BOOL)isHidden isAnimation:(BOOL)isAnimation {    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    [topVC.navigationController setNavigationBarHidden:isHidden animated:isAnimation];
}

- (void)setNavTitle:(NSString *)title withTitleColor:(NSString *)color withTitleSize:(NSInteger)size {
    

    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    topVC.title = title;
    UIColor *rgbColor;
    if (color && 0 != color.length ){
        rgbColor = [Native_ui colorFromHexCode:color];
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
 
