//
//  UIColor+GZBase.m
//  Appc
//
//  Created by 吕冬剑 on 2021/2/1.
//

#import "UIColor+GZBase.h"

@implementation UIColor (GZBase)

+(UIColor *)white2black{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return [UIColor whiteColor];
            }
            else {
                return [UIColor blackColor];
            }
        }];
    } else {
        return [UIColor whiteColor];
    }
}

+(UIColor *)color121212{
    return [UIColor colorWithRed:18/255.0 green:18/255.0 blue:18/255.0 alpha:1.0];
}

+(UIColor *)color111111{
    return [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
}

+(UIColor *)color6192CD{
    
    return [UIColor colorWithRed:97/255.0 green:146/255.0 blue:205/255.0 alpha:1.0];
}

+(UIColor *)color6192CD_20{
    return [UIColor colorWithRed:97/255.0 green:146/255.0 blue:205/255.0 alpha:0.2];
}

+(UIColor *)color8D8D8D{
    
    return [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1.0];
}

+(UIColor *)colorD8D8D8{
    
    return [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0];
}

+(UIColor *)color414141{
    
    return [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0];
}

+(UIColor *)color35343D{
    
    return [UIColor colorWithRed:53/255.0 green:52/255.0 blue:61/255.0 alpha:1.0];
}

+(UIColor *)colorF5F5F6{
    
    return [UIColor colorWithRed:245/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
}

+(UIColor *)colorF5F5F5{
    
    return [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
}

+(UIColor *)colorE8374A{
    
    return [UIColor colorWithRed:232/255.0 green:55/255.0 blue:74/255.0 alpha:1.0];
}

+(UIColor *)colorF0F0F0{
    
    return [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
}

+(UIColor *)color979797{
    
    return [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0];
}

+(UIColor *)color979797_02{
    
    return [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:0.2];
}

+(UIColor *)colorFFF5F6{
    
    return [UIColor colorWithRed:255/255.0 green:245/255.0 blue:246/246 alpha:1];
}
+(UIColor *)colorFFF1F3{
    
    return [UIColor colorWithRed:255/255.0 green:241/255.0 blue:243/246 alpha:1];
}

+(UIColor *)colorFFEDEF{
    return [UIColor colorWithRed:255/255.0 green:237/255.0 blue:239/255.0 alpha:1.0];
}
+(UIColor *)colorFFE7E9{
    
    return [UIColor colorWithRed:255/255.0 green:231/255.0 blue:233/255.0 alpha:1.0];
}
+(UIColor *)colorFDA7B0{
    
    return [UIColor colorWithRed:253/255.0 green:167/255.0 blue:176/255.0 alpha:1.0];
}
+(UIColor *)colorFFB2BB{
    
    return [UIColor colorWithRed:255/255.0 green:178/255.0 blue:187/255.0 alpha:1.0];
}

+(UIColor *)colorE3F0FF{
    
    return [UIColor colorWithRed:227/255.0 green:240/255.0 blue:255/255.0 alpha:1.0];
}

+(UIColor *)colorEB3F54{
    return [UIColor colorWithRed:235/255.0 green:63/255.0 blue:84/255.0 alpha:1.0];
}


+(UIColor *)color0A0A0A{
    return [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:1.0];
}

+(UIColor *)color7B6CF1{
    return [UIColor colorWithRed:123/255.0 green:108/255.0 blue:241/255.0 alpha:1.0];
}

+(UIColor *)colorFBD868{
    return [UIColor colorWithRed:251/255.0 green:216/255.0 blue:104/255.0 alpha:1.0];
}

+(UIColor *)colorF0FAE6{
    return [UIColor colorWithRed:240/255.0 green:250/255.0 blue:230/255.0 alpha:1.0];
}

+(UIColor *)colorFFF3F3{
    return [UIColor colorWithRed:255/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
}

+(UIColor *)color333333{
    return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
}
+(UIColor *)color999999{
    return [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
}
+(UIColor *)color666666{
    return [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
}
+(UIColor *)colorC1C0C9{
    return [UIColor colorWithRed:193/255.0 green:192/255.0 blue:201/255.0 alpha:1.0];
}

+(UIColor *)colorFFA824{
    return [UIColor colorWithRed:255/255.0 green:168/255.0 blue:36/255.0 alpha:1.0];
}

+(UIColor *)color89985D{
    return [UIColor colorWithRed:137/255.0 green:152/255.0 blue:93/255.0 alpha:1.0];
}

+(UIColor *)colorB96D6D{
    return [UIColor colorWithRed:185/255.0 green:109/255.0 blue:109/255.0 alpha:1.0];
}

+(UIColor *)color9B99A9{
    return [UIColor colorWithRed:155/255.0 green:153/255.0 blue:169/255.0 alpha:1.0];
}

+(UIColor *)colorFFFFFF{
    return [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
}

+(UIColor *)color98A869{
    return [UIColor colorWithRed:152.0/255.0 green:168.0/255.0 blue:105.0/255.0 alpha:1.0];
}

+(UIColor *)colorD59191{
    return [UIColor colorWithRed:213.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
}
+(UIColor *)colorF9F9F9{
    return [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
}
+(UIColor *)color757575{
    return [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
}
+(UIColor *)colorC1C1CA{
    return [UIColor colorWithRed:193/255.0 green:193/255.0 blue:202/255.0 alpha:1.0];
}
+(UIColor *)colorF7F8FA{
    return [UIColor colorWithRed:247/255.0 green:248/255.0 blue:250/255.0 alpha:1.0];
}
+(UIColor *)colorFF5F3B{
    return [UIColor colorWithRed:255/255.0 green:95/255.0 blue:59/255.0 alpha:1.0];
}

@end
