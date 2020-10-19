//
//  UIViewController+ZKScreenCache.m
//  nav
//
//  Created by 吕冬剑 on 2020/9/18.
//  Copyright © 2020 edz. All rights reserved.
//

#import "UIViewController+ZKScreenCache.h"
#import <objc/runtime.h>

static NSString *const imgKey = @"imgKey";
@implementation UIViewController (ZKScreenCache)

-(void)setScreenImage:(UIImage *)img{

    objc_setAssociatedObject(self, (__bridge const void *)(imgKey), img, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(UIImage *)getScreenImage{
    UIImage *img = objc_getAssociatedObject(self, (__bridge const void *)(imgKey));
    return img;
}

@end
