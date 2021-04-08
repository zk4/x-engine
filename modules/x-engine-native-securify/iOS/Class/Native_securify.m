//
//  Native_securify.m
//  securify
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_securify.h"
#import "NativeContext.h"
#import <UIKit/UIKit.h>

// userdefault中的key
#define X_ENGINE_MICROAPP_JSON @"microAppJson_KEY"

@interface Native_securify()
@property(nonatomic, strong) NSMutableDictionary *microAppJsonData;
@end

@implementation Native_securify
NATIVE_MODULE(Native_securify)

- (NSString*) moduleId{
    return @"com.zkty.native.securify";
}

- (int)order{
    return 0;
}

- (void)afterAllNativeModuleInited{}


- (instancetype)init {
    self = [super init];
    if (self) {
        _microAppJsonData = [NSMutableDictionary dictionary];
    }
    return self;
}

/// 保存microapp.json数据
/// @param jsonDict json数据
- (void)saveMicroAppJsonWithJson:(NSDictionary *)jsonDict {
    [_microAppJsonData setObject:jsonDict forKey:X_ENGINE_MICROAPP_JSON];
}

/// 判断模块是否可用
/// @param moduleName 模块名称
- (BOOL)judgeModuleIsAvailableWithModuleName:(NSString *)moduleName {
    NSDictionary *resultDict = [self getMicroAppJsonDataWithKeyName:X_ENGINE_MICROAPP_JSON];
    NSDictionary *modulesDict = resultDict[@"permission"][@"module"];
    NSArray *keyArray = modulesDict.allKeys;
    
    BOOL isHaveModule = [keyArray containsObject:moduleName];
    if (![moduleName isEqualToString:@"_dsb"]) {
        if (isHaveModule == 0) {
            NSString *str = [NSString stringWithFormat:@"%@模块没有使用权限", moduleName];
            UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [errorAlert addAction:sureAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:errorAlert animated:YES completion:^{}];
            return NO;
        }
    }
    return YES;
}

/// 判断网络白名单
/// @param hostName host名称
- (void)judgeNetworkIsAvailableWithHostName:(NSString *)hostName {
    NSDictionary *resultDict = [self getMicroAppJsonDataWithKeyName:X_ENGINE_MICROAPP_JSON];
    NSDictionary *permissionDict = resultDict[@"permission"];
    BOOL isStrict = [permissionDict[@"network"][@"strict"] boolValue];
    if (isStrict == 1) {
        NSArray *whiteHostArr = permissionDict[@"network"][@"white_host_list"];
        BOOL isContainsHost = [whiteHostArr containsObject:hostName];
        if (isContainsHost == 1) {
//            NSURLSessionDataTask * task = [manager dataTaskWithRequest:urlSchemeTask.request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
//            } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
//            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                [urlSchemeTask didReceiveResponse:response];
//                [urlSchemeTask didReceiveData:responseObject];
//                [urlSchemeTask didFinish];
//            }];
//            [task resume];
        } else {
            [self promptWithMessage:[NSString stringWithFormat:@"%@不在白名单内", hostName]];
        }
    }
}

/// 获取json数据 仅供本页面使用
- (NSMutableDictionary *)getMicroAppJsonDataWithKeyName:(NSString *)keyName{
    return [_microAppJsonData objectForKey:keyName];
}

/// 提示
/// @param message 提示内容
- (void)promptWithMessage:(NSString *)message  {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController popViewControllerAnimated:YES];
    }];
    [errorAlert addAction:sureAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:errorAlert animated:YES completion:^{}];
}
@end

