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
- (NSString *)getStatusHeight;
- (NSString *)getNavigationHeight;
- (NSString *)getScreenHeight;
- (NSString *)getTabbarHeight;
- (NSString *)callPhone:(NSString *)phoneNum;
- (NSString *)sendMsgWithPhoneNum:(NSString *)phoneNum withMsg:(NSString *)phoneMsg;
- (NSMutableDictionary *)getDeviceInfo;
@end
#endif /* iDevice_h */
