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



//- (void)_devicePhoneCall:(DevicePhoneNumDTO *)dto complete:(void (^)(BOOL))completionHandler {
//
//}
//
//- (void)_deviceSendMessage:(DeviceMessageDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getBatteryLevel:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getNavigationHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//    DeviceMoreDTO* ret = [DeviceMoreDTO new];
//    ret.content = [self.device getNavigationHeight];
//    completionHandler(ret,TRUE);
//}

//
//- (void)_getPhoneType:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getPreferredLanguage:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getSafeAreaBottom:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getSafeAreaLeft:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getSafeAreaRight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getSafeAreaTop:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getScreenHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getScreenWidth:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getStatusHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getSystemVersion:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getTabBarHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
//
//- (void)_getUDID:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler {
//
//}
 
- (_0_com_zkty_jsi_device_DTO *)_getNavigationHeight {
    _0_com_zkty_jsi_device_DTO * ret =[_0_com_zkty_jsi_device_DTO new];
    ret.height =@"hello";
    return ret;
}

@end
