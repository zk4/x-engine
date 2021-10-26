//
//  Native_device.m
//  device
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 x-engine. All rights reserved.


#import "Native_device.h"
#import "XENativeContext.h"
#import <x-engine-native-core/Unity.h>
#import <sys/sysctl.h>


@interface Native_device()
@end

@implementation Native_device
NATIVE_MODULE(Native_device)

- (NSString*) moduleId{
    return @"com.zkty.native.device";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{}

- (NSString *)getStatusHeight {
    NSString *hexightStr= [NSString stringWithFormat:@"%.2f", [[UIApplication sharedApplication] statusBarFrame].size.height];
    return hexightStr;
}

- (NSString *)getNavigationHeight {
    NSString *heightStr = [NSString stringWithFormat:@"%.2f",[Unity sharedInstance].getCurrentVC.navigationController.navigationBar.frame.size.height];
    return heightStr;
}

- (NSString *)getScreenHeight {
    NSString *heightStr = [NSString stringWithFormat:@"%.2f", [UIScreen mainScreen].bounds.size.height];
    return heightStr;
}


- (float)getTabbarHeight {
    return  [[UIApplication sharedApplication] statusBarFrame].size.height > 20.0f ? 83.0f : 49.0f;
}

- (NSString *)callPhone:(NSString *)phoneNum {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    return @"call phone";
}

- (NSString *)sendMsgWithPhoneNum:(NSString *)phoneNum withMsg:(NSString *)phoneMsg {
    NSString *str = [NSString stringWithFormat:@"sms://%@&body=%@", phoneNum, phoneMsg];
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    return @"send message";
}

- (NSMutableDictionary *)getDeviceInfo {
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    NSString *systemName = [UIDevice currentDevice].systemName;
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSString *UUID = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSString *photoType = [self userDeviceName];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:photoType forKey:@"photoType"];
    [dict setValue:systemName forKey:@"type"];
    [dict setValue:systemVersion forKey:@"systemVersion"];
    [dict setValue:language forKey:@"language"];
    [dict setValue:UUID forKey:@"UUID"];
    return dict;
}

- (NSString *) userDeviceName {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone (1st generation)";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM, 2nd revision)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (Verizon)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8 (GSM)";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus (GSM)";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X (GSM)";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"])   return @"iPhone SE (2nd generation)";
    if ([platform isEqualToString:@"iPhone13,1"])   return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"])   return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"])   return @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPhone14,2"])   return @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"])   return @"iPhone 13 Pro Max";
    if ([platform isEqualToString:@"iPhone14,4"])   return @"iPhone 13 mini";
    if ([platform isEqualToString:@"iPhone14,5"])   return @"iPhone 13";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1st generation)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2nd generation)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3rd generation)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4th generation)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5th generation)";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch (6th generation)";
    if ([platform isEqualToString:@"iPod9,1"])      return @"iPod Touch (7th generation) (2019)";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad (1st generation)";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (Wi-Fi, Mid 2012)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad (3rd generation) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad (3rd generation) (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad (3rd generation) (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad (4th generation) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad (4th generation) (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad (4th generation) (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad6,11"])     return @"iPad (5th generation) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad6,12"])     return @"iPad (5th generation) (Cellular)";
    if ([platform isEqualToString:@"iPad7,5"])      return @"iPad (6th generation) (2018) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad7,6"])      return @"iPad (6th generation) (2018) (Cellular)";
    if ([platform isEqualToString:@"iPad7,11"])     return @"iPad (7th generation) (2019) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad7,12"])     return @"iPad (7th generation) (2019) (Cellular)";
    if ([platform isEqualToString:@"iPad11,6"])     return @"iPad (8th generation) (2020) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad11,7"])     return @"iPad (8th generation) (2020) (Cellular)";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (Wi-Fi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (China)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad11,3"])     return @"iPad Air (3rd generation) (2019) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad11,4"])     return @"iPad Air (3rd generation) (2019) (Cellular)";
    if ([platform isEqualToString:@"iPad13,1"])     return @"iPad Air (4th generation) (2020) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad13,2"])     return @"iPad Air (4th generation) (2020) (Cellular)";
    
    //iPad Pro
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7\" (Wi-Fi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7\" (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9\" (Wi-Fi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9\" (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9\" (2nd generation) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9\" (2nd generation) (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5\" (Wi-Fi)";
    if ([platform isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5\" (Cellular)";
    if ([platform isEqualToString:@"iPad8,1"])      return @"iPad Pro 11\" (2018) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad8,2"])      return @"iPad Pro 11\" (2018) (Wi-Fi, 1TB)";
    if ([platform isEqualToString:@"iPad8,3"])      return @"iPad Pro 11\" (2018) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad8,4"])      return @"iPad Pro 11\" (2018) (Cellular)";
    if ([platform isEqualToString:@"iPad8,5"])      return @"iPad Pro 12.9\" (3rd generation) (2018) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad8,6"])      return @"iPad Pro 12.9\" (3rd generation) (2018) (Cellular)";
    if ([platform isEqualToString:@"iPad8,7"])      return @"iPad Pro 12.9\" (3rd generation) (2018) (Wi-Fi, 1TB)";
    if ([platform isEqualToString:@"iPad8,8"])      return @"iPad Pro 12.9\" (3rd generation) (2018) (Cellular, 1TB)";
    if ([platform isEqualToString:@"iPad8,9"])      return @"iPad Pro 11\" (2nd generation) (2020) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad8,10"])     return @"iPad Pro 11\" (2nd generation) (2020) (Cellular)";
    if ([platform isEqualToString:@"iPad8,11"])     return @"iPad Pro 12.9\" (4th generation) (2020) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad8,12"])     return @"iPad Pro 12.9\" (4th generation) (2020) (Cellular)";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad mini (Wi-Fi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad mini 2 (China)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad mini 3 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad mini 3 (China)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad mini 4 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad11,1"])     return @"iPad mini (5th generation) (2019) (Wi-Fi)";
    if ([platform isEqualToString:@"iPad11,2"])     return @"iPad mini (5th generation) (2019) (Cellular)";
    
    //Apple TV
    if ([platform isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([platform isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3 (2013)";
    if ([platform isEqualToString:@"AppleTV5,3"])   return @"Apple TV 4";
    if ([platform isEqualToString:@"AppleTV6,2"])   return @"Apple TV 4K";
    
    //Apple Watch
    if ([platform isEqualToString:@"Watch1,1"])     return @"Apple Watch (1st generation) (38mm)";
    if ([platform isEqualToString:@"Watch1,2"])     return @"Apple Watch (1st generation) (42mm)";
    if ([platform isEqualToString:@"Watch2,6"])     return @"Apple Watch Series 1 (38mm)";
    if ([platform isEqualToString:@"Watch2,7"])     return @"Apple Watch Series 1 (42mm)";
    if ([platform isEqualToString:@"Watch2,3"])     return @"Apple Watch Series 2 (38mm)";
    if ([platform isEqualToString:@"Watch2,4"])     return @"Apple Watch Series 2 (42mm)";
    if ([platform isEqualToString:@"Watch3,1"])     return @"Apple Watch Series 3 (38mm Cellular)";
    if ([platform isEqualToString:@"Watch3,2"])     return @"Apple Watch Series 3 (42mm Cellular)";
    if ([platform isEqualToString:@"Watch3,3"])     return @"Apple Watch Series 3 (38mm)";
    if ([platform isEqualToString:@"Watch3,4"])     return @"Apple Watch Series 3 (42mm)";
    if ([platform isEqualToString:@"Watch4,1"])     return @"Apple Watch Series 4 (40mm)";
    if ([platform isEqualToString:@"Watch4,2"])     return @"Apple Watch Series 4 (44mm)";
    if ([platform isEqualToString:@"Watch4,3"])     return @"Apple Watch Series 4 (40mm Cellular)";
    if ([platform isEqualToString:@"Watch4,4"])     return @"Apple Watch Series 4 (44mm Cellular)";
    if ([platform isEqualToString:@"Watch5,1"])     return @"Apple Watch Series 5 (40mm)";
    if ([platform isEqualToString:@"Watch5,2"])     return @"Apple Watch Series 5 (44mm)";
    if ([platform isEqualToString:@"Watch5,3"])     return @"Apple Watch Series 5 (40mm Cellular)";
    if ([platform isEqualToString:@"Watch5,4"])     return @"Apple Watch Series 5 (44mm Cellular)";
    if ([platform isEqualToString:@"Watch6,1"])     return @"Apple Watch Series 6 (40mm)";
    if ([platform isEqualToString:@"Watch6,2"])     return @"Apple Watch Series 6 (44mm)";
    if ([platform isEqualToString:@"Watch6,3"])     return @"Apple Watch Series 6 (40mm Cellular)";
    if ([platform isEqualToString:@"Watch6,4"])     return @"Apple Watch Series 6 (44mm Cellular)";
    if ([platform isEqualToString:@"Watch5,9"])     return @"Apple Watch SE (40mm)";
    if ([platform isEqualToString:@"Watch5,10"])    return @"Apple Watch SE (44mm)";
    if ([platform isEqualToString:@"Watch5,11"])    return @"Apple Watch SE (40mm Cellular)";
    if ([platform isEqualToString:@"Watch5,12"])    return @"Apple Watch SE (44mm Cellular)";
    
    //Simulator
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}@end

