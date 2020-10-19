//
//  UIImage+XEnging_UI.m
//  x-engine-module-ui
//
//  Created by edz on 2020/8/3.
//

#import "UIImage+XEnging_UI.h"
#import "XEngine-UI-ResourcesLoader.h"
@implementation UIImage (XEnging_UI)
+ (UIImage *)imageNamed:(NSString *)imageName inAssets:(NSString *)assetsName
{
    return [XEngine_UI_ResourcesLoader imageNamed:imageName inAssets:assetsName];
}
@end
