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
typedef void(^completeContactInfo)(NSDictionary *contactInfo);

@protocol iDevice <NSObject>
@property (nonatomic, copy)void(^contactInfoBlock)(NSDictionary *contactInfo);
- (NSString *)getStatusHeight;
- (NSString *)getNavigationHeight;
- (NSString *)getScreenHeight;
- (float)getTabbarHeight;
- (NSString *)callPhone:(NSString *)phoneNum;
- (NSString *)sendMsgWithPhoneNum:(NSString *)phoneNum withMsg:(NSString *)phoneMsg;
- (NSMutableDictionary *)getDeviceInfo;
- (void)pickContactInfo;
@end
#endif /* iDevice_h */
