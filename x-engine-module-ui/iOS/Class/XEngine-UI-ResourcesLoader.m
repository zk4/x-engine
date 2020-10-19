//
//  XEngine-UI-ResourcesLoader.m
//  x-engine-module-ui
//
//  Created by edz on 2020/8/3.
//

#import "XEngine-UI-ResourcesLoader.h"

NSString *const XEngine_UI_ResourcesBundleName = @"xengine-ui";

@implementation XEngine_UI_ResourcesLoader

+ (NSBundle *)frameworkBundle
{
    
    
    NSBundle *podBundle = [NSBundle bundleForClass:[self class]];
    NSString *bundlePath = [podBundle pathForResource:XEngine_UI_ResourcesBundleName ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

+ (UIImage *)imageNamed:(NSString *)imageName inAssets:(NSString *)assetsName
{
    NSBundle *bundle = [self frameworkBundle];
    
    if (bundle) {
        // NSLog(@"Testing Framework 里bundle path: %@", [libBundle resourcePath]);
        
        NSString *path = [[bundle resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xcassets", assetsName]];
        path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.imageset", imageName]];
        path = [path stringByAppendingPathComponent:imageName];
        
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
        
        // NSLog(@"Testing Framework image size: %f, %f", image.size.width, image.size.height);
        return image;
    }
    return nil;
}
@end
