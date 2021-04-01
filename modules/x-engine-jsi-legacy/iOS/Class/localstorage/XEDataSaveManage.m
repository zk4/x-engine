//
//  XEDataSaveManage.m
//  ModuleApp
//
//  Created by 吕冬剑 on 2020/9/29.
//  Copyright © 2020 edz. All rights reserved.
//

#import "XEDataSaveManage.h"
#import "MicroAppLoader.h"

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
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

// 获取
- (NSString *)getLocalStorage:(NSString *)key withIsPublic:(BOOL)isPublic{
    
    NSUserDefaults *defaults;

    if(self.staticDic[key]){
        return self.staticDic[key];
    }
    defaults = [NSUserDefaults standardUserDefaults];
 
    NSString *value = [defaults objectForKey: key];
    if(value.length < 1){
        value = nil;
    }
    return value;
}

// 删除某一个
- (void)removeLocalStorageItem:(NSString *)key withIsPublic:(BOOL)isPublic {
    NSUserDefaults *defaults;
   
    defaults = [NSUserDefaults standardUserDefaults];

    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

// 删除全部
- (void)removeLocalStorageAll:(BOOL)isPublic {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}
 
@end
