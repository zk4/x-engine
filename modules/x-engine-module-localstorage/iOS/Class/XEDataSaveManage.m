//
//  XEDataSaveManage.m
//  ModuleApp
//
//  Created by 吕冬剑 on 2020/9/29.
//  Copyright © 2020 edz. All rights reserved.
//

#import "XEDataSaveManage.h"
#import <x-engine-module-engine/MicroAppLoader.h>

@interface XEDataSaveManage ()

@property (nonatomic, strong) NSMutableDictionary *staticDic;

@end

@implementation XEDataSaveManage

+(instancetype)instance{
    static dispatch_once_t onceToken;
    static XEDataSaveManage *manage;
    dispatch_once(&onceToken, ^{
        manage = [[XEDataSaveManage alloc] init];
    });
    return manage;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.staticDic = [@{} mutableCopy];
    }
    return self;
}

-(void)setStaticKey:(NSString *)staticKey withStaticValue:(NSString *)value{
    if(staticKey){
        self.staticDic[staticKey] = value;
    }
}

// 设置
- (void)setLocalStorage:(NSString *)key withValue:(NSString *)value withIsPublic:(BOOL)isPublic {
    NSUserDefaults *defaults;
    if(isPublic){
        
        defaults = [NSUserDefaults standardUserDefaults];
    } else {
        
        defaults = [[NSUserDefaults alloc] initWithSuiteName:[MicroAppLoader sharedInstance].nowMicroAppId];
    }
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

// 获取
- (NSString *)getLocalStorage:(NSString *)key withIsPublic:(BOOL)isPublic{
    
    NSUserDefaults *defaults;
    if(isPublic){
        if(self.staticDic[key]){
            return self.staticDic[key];
        }
        defaults = [NSUserDefaults standardUserDefaults];
    } else {
        defaults = [[NSUserDefaults alloc] initWithSuiteName:[MicroAppLoader sharedInstance].nowMicroAppId];
    }
    NSString *value = [defaults objectForKey: key];
    if(value.length < 1){
        value = nil;
    }
    return value;
}

// 删除某一个
- (void)removeLocalStorageItem:(NSString *)key withIsPublic:(BOOL)isPublic {
    NSUserDefaults *defaults;
    if(isPublic){
        defaults = [NSUserDefaults standardUserDefaults];
    } else {
        defaults = [[NSUserDefaults alloc] initWithSuiteName:[MicroAppLoader sharedInstance].nowMicroAppId];
    }
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

// 删除全部
- (void)removeLocalStorageAll:(BOOL)isPublic {
    
    if(isPublic){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    }else{
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:[MicroAppLoader sharedInstance].nowMicroAppId];
        [defaults removePersistentDomainForName:[MicroAppLoader sharedInstance].nowMicroAppId];
    }
}

//// 设置
//+ (void)setLocalStorage2:(NSString *)key withValue:(NSString *)value withIsPublic:(BOOL)isPublic {
//    NSUserDefaults *defaults;
//    if(isPublic){
//        
//        defaults = [NSUserDefaults standardUserDefaults];
//    } else {
//        defaults = [[NSUserDefaults alloc] initWithSuiteName:@"temp"];
//    }
//    [defaults setObject:value forKey:key];
//    [defaults synchronize];
//}
//
//// 获取
//+ (NSString *)getLocalStorage2:(NSString *)key withIsPublic:(BOOL)isPublic{
//    
//    NSUserDefaults *defaults;
//    if(isPublic){
//        defaults = [NSUserDefaults standardUserDefaults];
//    } else {
//        defaults = [[NSUserDefaults alloc] initWithSuiteName:@"temp"];
//    }
//    NSString *value = [defaults objectForKey: key];
//    return value;
//}
@end
