//
//  Prefix.h
//  XEngineApp
//
//  Created by edz on 2020/7/27.
//  Copyright © 2020 edz. All rights reserved.
//

#ifndef Prefix_h
#define Prefix_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <WebKit/WebKit.h>


 #import "ZYDL_TabBarController.h"



#define kBundle                 [NSBundle mainBundle]
#define kDevice                 [UIDevice currentDevice]
#define kKeyWindow              kApplication.keyWindow
#define kRootVC                 kApplication.keyWindow.rootViewController
#define kScreenBounds           [UIScreen mainScreen].bounds

#define kFileManager            [NSFileManager defaultManager]
#define kApplication            [UIApplication sharedApplication]
#define kNotificationCenter     [NSNotificationCenter defaultCenter]
#define kUserDefaults           [NSUserDefaults standardUserDefaults]
#define kWidth                  (kScreenBounds.size.width)
#define kHeight                 (kScreenBounds.size.height)
#define kVersion                [kDevice systemVersion]

#define kIPHONE4                (kScreenBounds.size.height == 480)           // 设备4
#define kIPHONE5                (kScreenBounds.size.height == 568)           // 设备5
#define kIPHONE6S               (kScreenBounds.size.height == 667)           // 设备6  6s  7  高度
#define kIPHONE6SP              (kScreenBounds.size.height == 736)           // 设备6p 6sp 7p 高度
#define kIPHONEX                (kScreenBounds.size.height > 736)            // 设备6p 6sp 7p 高度

#define kIOS9                   (kVersion.integerValue == 9)                 // iOS9
#define kIOS10                  (kVersion.integerValue == 10)                // iOS10
#define kIOS11                  (kVersion.integerValue == 11)                // iOS11
#define kIOS12                  (kVersion.integerValue == 12)                // iOS12

#define kStatusBarH             (CGFloat)(kIPHONEX?(44):(20))                // 状态栏高度
#define kNavigationH            (CGFloat)(kIPHONEX?(88):(64))                // 状态栏和导航栏总高度
#define kTabBarH                (CGFloat)(kIPHONEX?(49):(49))                // TabBar高度
#define kBottomSafeHeight       (CGFloat)(kIPHONEX?(34):(0))                 // 底部安全区域远离高度


#define kEEEEEFColor            [UIColor colorWithHexString:@"EEEEEF"]
#define kF7F7F7Color            [UIColor colorWithHexString:@"F7F7F7"]
#define kRGBColor(r, g, b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kRGBAColor(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

//#define SERVERHOST @"http://127.0.0.1:8000/"
#define SERVERHOST @"https://3rd-public-file.oss-cn-beijing.aliyuncs.com/"
#endif /* Prefix_h */
