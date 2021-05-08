//
//  Native_device.m
//  device
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_device.h"
#import "NativeContext.h"

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
    NSString *heightStr = [NSString stringWithFormat:@"%.2f", [[UIApplication sharedApplication] statusBarFrame].size.height];
    return heightStr;
}

- (NSString *)getNavigationHeight {
    CGFloat navigationHeight = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 68 : 44;
    NSString *heightStr = [NSString stringWithFormat:@"%.f",navigationHeight];
    return heightStr;
}

- (NSString *)getScreenHeight {
    NSString *heightStr = [NSString stringWithFormat:@"%.2f", [UIScreen mainScreen].bounds.size.height];
    return heightStr;
}


- (NSString *)getTabbarHeight {
    CGFloat tabBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49;
    NSString *heightStr = [NSString stringWithFormat:@"%.f",tabBarHeight];
    return heightStr;
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
    NSString *systemName = [UIDevice currentDevice].systemName;
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    NSString *UUID = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:systemName forKey:@"type"];
    [dict setValue:systemVersion forKey:@"systemVersion"];
    [dict setValue:language forKey:@"language"];
    [dict setValue:UUID forKey:@"UUID"];
    return dict;
}
@end
 
