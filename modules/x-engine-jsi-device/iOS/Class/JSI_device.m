//
//  JSI_device.m
//  device
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 x-engine. All rights reserved.


#import "JSI_device.h"
#import "JSIContext.h"
#import "XENativeContext.h"
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
    return [NSString stringWithFormat:@"%.2f" ,[self.device getTabbarHeight]];
}

- (NSString *)_callPhone:(phoneDto *)dto {
    return[self.device callPhone:dto.phoneNum];
}

- (NSString *)_sendMessage:(phoneDto *)dto {
    return [self.device sendMsgWithPhoneNum:dto.phoneNum withMsg:dto.phoneMsg];
}

- (void)_getDeviceInfo:(void (^)(DeviceDTO *, BOOL))completionHandler {
    NSMutableDictionary *dict = [self.device getDeviceInfo];
    DeviceDTO *dto = [[DeviceDTO alloc] init];
    dto.UUID = dict[@"UUID"];
    dto.type = dict[@"type"];
    dto.language = dict[@"language"];
    dto.photoType = dict[@"photoType"];
    dto.systemVersion = dict[@"systemVersion"];
    completionHandler(dto, true);
}

- (void)_pickContact:(void (^)(_pickContact_com_zkty_jsi_device_0_DTO *, BOOL))completionHandler{
    __weak typeof(self) weakSelf = self;
    self.device.contactInfoBlock = ^(NSDictionary *contactInfo) {
        _pickContact_com_zkty_jsi_device_0_DTO *dto = [_pickContact_com_zkty_jsi_device_0_DTO new];
        dto.name = contactInfo[@"name"];
        dto.phone = contactInfo[@"phone"];
        if (completionHandler) {
            completionHandler(dto, true);
        }
    };
    [self.device pickContactInfo];
}

@end
