//
//  NPDDeviceManager_SDK.h
//  LopeKit
//
//  Created by tangjie on 2017/4/19.
//  Copyright © 2017年 tangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPDDeviceManager : NSObject

+ (NSString *)appBundleID;

+ (NSString *)appVersion;

+ (NSString *)appName;

+ (NSString *)deviceModel;

+ (NSString *)resolution;

+ (NSString *)rom;

+ (NSString *)ip;

@end
