//
//  iDevice.h
//  Device
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#ifndef iDevice_h
#define iDevice_h

@class DeviceSheetModel, DeviceMoreModel;

@protocol iDevice <NSObject>

- (NSString*)getNavigationHeight;

//- (void)devicePhoneCall:(DevicePhoneNumModel *)dto complete:(void (^)(BOOL))completionHandler;
//
//- (void)deviceSendMessage:(DeviceMessageDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getBatteryLevel:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getNavigationHeight:(NSString *)dto complete:(void (^)(DeviceMoreModel *, BOOL))completionHandler;

//- (void)getPhoneType:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getPreferredLanguage:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getSafeAreaBottom:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getSafeAreaLeft:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getSafeAreaRight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getSafeAreaTop:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getScreenHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getScreenWidth:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getStatusHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler
//
//- (void)getSystemVersion:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getTabBarHeight:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;
//
//- (void)getUDID:(DeviceSheetDTO *)dto complete:(void (^)(DeviceMoreDTO *, BOOL))completionHandler;

@end
#endif /* iDevice_h */
