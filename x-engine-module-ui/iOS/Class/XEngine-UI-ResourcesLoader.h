//
//  XEngine-UI-ResourcesLoader.h
//  x-engine-module-ui
//
//  Created by edz on 2020/8/3.
//

#import <UIKit/UIKit.h>



@interface XEngine_UI_ResourcesLoader : NSObject
+ (NSBundle *)frameworkBundle;

+ (UIImage *)imageNamed:(NSString *)imageName inAssets:(NSString *)assetsName;
@end


