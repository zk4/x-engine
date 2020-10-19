//
//  NPDLogManager.h
//  LopeKit
//
//  Created by tangjie on 2017/4/17.
//  Copyright © 2017年 tangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPDLogManager : NSObject

+ (void)setEnableLog:(BOOL)enable;

+ (void)printLog:(NSString *)log;

+ (void)debug:(NSString *)message;

+ (void)info:(NSString *)message;

@end
