//
//  JSI_device.m
//  device
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_device.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "iDevice.h"

@interface JSI_device()
@property(nonatomic,strong) id<iDevice> device;
@end

@implementation JSI_device
JSI_MODULE(JSI_device)

- (void)afterAllJSIModuleInited {
    self.device = XENP(iDevice);
}

- (NSString *)_getNavigationHeight {
    return [self.device getNavigationHeight];
}

- (NSString *)_getScreenHeight {
    return [self.device getScreenHeight];
}

- (NSString *)_getStatusBarHeight {
    return [self.device getStatusHeight];
}

- (NSString *)_getTabbarHeight {
    return [self.device getTabbarHeight];
}

- (NSString *)_callPhone:(phoneDto *)dto {
    return[self.device callPhone:dto.phoneNum];
}

- (NSString *)_sendMessage:(phoneDto *)dto {
    return [self.device sendMsgWithPhoneNum:dto.phoneNum withMsg:dto.phoneMsg];
}

- (NSString *)_getDeviceInfo {
    return [self.device getDeviceInfo];
}

- (DeviceDTO *)_getDeviceInfo1 {
    NSMutableDictionary *dict = [self.device getDeviceInfo1];
    DeviceDTO *dto = [[DeviceDTO alloc] init];
    dto.UUID = dict[@"UUID"];
    dto.type = dict[@"type"];
    dto.language = dict[@"language"];
    dto.systemVersion = dict[@"systemVersion"];
    return dto;
}
@end
