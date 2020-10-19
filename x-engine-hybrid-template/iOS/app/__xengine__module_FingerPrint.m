//
//  __xengine__module_FingerPrint.m
//  XEngineSDKDemo
//
//  Created by edz on 2020/7/29.
//  Copyright © 2020 edz. All rights reserved.
//

#import "__xengine__module_FingerPrint.h"
#import <LocalAuthentication/LocalAuthentication.h>
@implementation __xengine__module_FingerPrint
///指纹识别
- (void)verificationFingerPrint:(NSDictionary *)data callBack:(XEngineCallBack)completionHandler
{
     //首先判断版本
        if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
            NSLog(@"系统版本不支持TouchID");
            [self showAlertWithMessage:@"系统版本不支持TouchID"];
            return;
        }
        
        
        LAContext *context = [[LAContext alloc] init];
        context.localizedFallbackTitle = @"输入密码";
    
        if (@available(iOS 10.0, *)) {
    //        context.localizedCancelTitle = @"22222";
        } else {
            // Fallback on earlier versions
        }
        NSError *error = nil;
      
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
            NSString *localizedReason = @"指纹登录";
            if (context.biometryType == LABiometryTypeTouchID)
            {
                               
                           
            }else if (context.biometryType == LABiometryTypeFaceID)
            {
                localizedReason = @"Face ID登录";
            }

            
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:localizedReason  reply:^(BOOL success, NSError * _Nullable error) {
                
                if (success) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 验证成功");
                    });
                }else if(error){
                    
                    switch (error.code) {
                        case LAErrorAuthenticationFailed:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 验证失败");
                            });
                            break;
                        }
                        case LAErrorUserCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 被用户手动取消");
                            });
                        }
                            break;
                        case LAErrorUserFallback:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"用户不使用TouchID,选择手动输入密码");
                            });
                        }
                            break;
                        case LAErrorSystemCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                            });
                        }
                            break;
                        case LAErrorPasscodeNotSet:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 无法启动,因为用户没有设置密码");
                            });
                        }
                            break;
                        case LAErrorBiometryNotEnrolled:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
                            });
                        }
                            break;
                        case LAErrorBiometryNotAvailable:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 无效");
                            });
                        }
                            break;
                        case LAErrorBiometryLockout:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                            });
                        }
                            break;
                        case LAErrorAppCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                            });
                        }
                            break;
                        case LAErrorInvalidContext:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                            });
                        }
                            break;
                        default:
                            break;
                    }
                    // 失败
//                    [self showAlertWithMessage:@"验证失败"];
                }
            }];
            
        }else{
            NSLog(@"当前设备不支持TouchID");
            [self showAlertWithMessage:@"当前设备不支持TouchID"];
        }
}


- (void)showAlertWithMessage:(NSString *)message
{
    [[Unity sharedInstance].getCurrentVC showAlertWithTitle:@"" message:message sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {
        
    }];
}
@end
