//
//  xengine__module_device.m
//  device
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_device.h"
#import <XEngineContext.h>
#import <micros.h>
#import <x-engine-module-tools/UIViewController+.h>
#import <x-engine-module-tools/JSONToDictionary.h>
#import <x-engine-module-microApp/Unity.h>
#import <sys/utsname.h>

@interface __xengine__module_device()
@end

@implementation __xengine__module_device

- (void)_getPhoneType:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString *phoneType = [self getDeviceName];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content=phoneType;
    completionHandler(d, YES);
}

-(void)_getSystemVersion:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler{
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content=systemVersion;
    completionHandler(d, YES);
}

- (void)_getUDID:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString *UDID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content=UDID;
    completionHandler(d, YES);
}

- (void)_getBatteryLevel:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString* batteryLevel = [NSString stringWithFormat:@"%.f",[[UIDevice currentDevice] batteryLevel]];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content=batteryLevel;
    completionHandler(d, YES);
}

- (void)_getPreferredLanguage:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString *preferredLanguage = [[[NSBundle mainBundle] preferredLocalizations] firstObject];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content=preferredLanguage;
    completionHandler(d, YES);
}

- (void)_getScreenWidth:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString* screenWidth = [NSString stringWithFormat:@"%.f",[[UIScreen mainScreen]bounds].size.width];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content=screenWidth;
    completionHandler(d, YES);
}

- (void)_getScreenHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString* screenHeight = [NSString stringWithFormat:@"%.f",[[UIScreen mainScreen]bounds].size.height];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content = screenHeight;
    completionHandler(d, YES);
}

- (void)_getSafeAreaTop:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString * safeAreaTop = [NSString stringWithFormat:@"%.f",[[[UIApplication sharedApplication] delegate] window].safeAreaInsets.top];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content = safeAreaTop;
    completionHandler(d, YES);
}

- (void)_getSafeAreaBottom:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString* safeAreaBottom = [NSString stringWithFormat:@"%.f",[[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content = safeAreaBottom;
    completionHandler(d, YES);
}

- (void)_getSafeAreaLeft:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString* safeAreaLeft = [NSString stringWithFormat:@"%.f",[[[UIApplication sharedApplication] delegate] window].safeAreaInsets.left];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content = safeAreaLeft;
    completionHandler(d, YES);
}

- (void)_getSafeAreaRight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString* safeAreaRight = [NSString stringWithFormat:@"%.f",[[[UIApplication sharedApplication] delegate] window].safeAreaInsets.right];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content = safeAreaRight;
    completionHandler(d, YES);
}

- (void)_getStatusHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    NSString* statusHeight = [NSString stringWithFormat:@"%.f",[[UIApplication sharedApplication] statusBarFrame].size.height];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content = statusHeight;
    completionHandler(d, YES);
}

- (void)_getNavigationHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    CGFloat navigationHeight = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 88 : 64;
    NSString * navigationHeightStr = [NSString stringWithFormat:@"%.f",navigationHeight];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content = navigationHeightStr;
    completionHandler(d, YES);
}

- (void)_getTabBarHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
    CGFloat tabBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49;
    NSString * tabBarHeightStr = [NSString stringWithFormat:@"%.f",tabBarHeight];
    DeviceMoreDTO* d = [DeviceMoreDTO new];
    d.content = tabBarHeightStr;
    completionHandler(d, YES);
}

//获取手机型号
- (NSString *)getDeviceName {
    NSString* padType = @"";
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";

    if ([deviceString isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";

    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";

    if ([deviceString isEqualToString:@"iPad1,1"]){
        padType = @"ipad";
        return @"iPad";
    }
    if ([deviceString isEqualToString:@"iPad1,2"]){
        padType = @"ipad";
        return @"iPad 3G";
    }
    if ([deviceString isEqualToString:@"iPad2,1"]){
        padType = @"ipad";
        return @"iPad 2 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad2,2"]){
        padType = @"ipad";
        return @"iPad 2";
    }
    if ([deviceString isEqualToString:@"iPad2,3"]){
        padType = @"ipad";
        return @"iPad 2 (CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad2,4"]){
        padType = @"ipad";
        return @"iPad 2";
    }
    if ([deviceString isEqualToString:@"iPad2,5"]){
        padType = @"ipad";
        return @"iPad Mini (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad2,6"]){
        padType = @"ipad";
        return @"iPad Mini";
    }
    if ([deviceString isEqualToString:@"iPad2,7"]){
        padType = @"ipad";
        return @"iPad Mini (GSM+CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad3,1"]){
        padType = @"ipad";
        return @"iPad 3 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad3,2"]){
        padType = @"ipad";
        return @"iPad 3 (GSM+CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad3,3"]){
        padType = @"ipad";
        return @"iPad 3";
    }
    if ([deviceString isEqualToString:@"iPad3,4"]){
        padType = @"ipad";
        return @"iPad 4 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad3,5"]){
        padType = @"ipad";
        return @"iPad 4";
    }
    if ([deviceString isEqualToString:@"iPad3,6"]){
        padType = @"ipad";
        return @"iPad 4 (GSM+CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad4,1"]){
        padType = @"ipad";
        return @"iPad Air (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad4,2"]){
        padType = @"ipad";
        return @"iPad Air (Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad4,4"]){
        padType = @"ipad";
        return @"iPad Mini 2 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad4,5"]){
        padType = @"ipad";
        return @"iPad Mini 2 (Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad4,6"]){
        padType = @"ipad";
        return @"iPad Mini 2";
    }
    if ([deviceString isEqualToString:@"iPad4,7"]){
        padType = @"ipad";
        return @"iPad Mini 3";
    }
    if ([deviceString isEqualToString:@"iPad4,8"]){
        padType = @"ipad";
        return @"iPad Mini 3";
    }
    if ([deviceString isEqualToString:@"iPad4,9"]){
        padType = @"ipad";
        return @"iPad Mini 3";
    }
    if ([deviceString isEqualToString:@"iPad5,1"]){
        padType = @"ipad";
        return @"iPad Mini 4 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad5,2"]){
        padType = @"ipad";
        return @"iPad Mini 4 (LTE)";
    }
    if ([deviceString isEqualToString:@"iPad5,3"]){
        padType = @"ipad";
        return @"iPad Air 2";
    }
    if ([deviceString isEqualToString:@"iPad5,4"]){
        padType = @"ipad";
        return @"iPad Air 2";
    }
    if ([deviceString isEqualToString:@"iPad6,3"]){
        padType = @"ipad";
        return @"iPad Pro 9.7";
    }
    if ([deviceString isEqualToString:@"iPad6,4"]){
        padType = @"ipad";
        return @"iPad Pro 9.7";
    }
    if ([deviceString isEqualToString:@"iPad6,7"]){
        padType = @"ipad";
        return @"iPad Pro 12.9";
    }
    if ([deviceString isEqualToString:@"iPad6,8"]){
        padType = @"ipad";
        return @"iPad Pro 12.9";
    }
    if ([deviceString isEqualToString:@"iPad6,11"]){
        padType = @"ipad";
        return @"iPad 5 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad6,12"]){
        padType = @"ipad";
        return @"iPad 5 (Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad7,1"]){
        padType = @"ipad";
        return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad7,2"]){
        padType = @"ipad";
        return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad7,3"]){
        padType = @"ipad";
        return @"iPad Pro 10.5 inch (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad7,4"]){
        padType = @"ipad";
        return @"iPad Pro 10.5 inch (Cellular)";
    }

    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";

    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";

    return deviceString;
}


@end
 
