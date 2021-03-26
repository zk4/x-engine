//
//  XEDataSaveManage.h
//  ModuleApp
//
//  Created by 吕冬剑 on 2020/9/29.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface XEDataSaveManage : NSObject

+(instancetype)instance;

-(void)setStaticKey:(NSString *)staticKey withStaticValue:(NSString *)value;

- (void)setLocalStorage:(NSString *)key withValue:(NSString *)value withIsPublic:(BOOL)isPublic;

// 获取
- (NSString *)getLocalStorage:(NSString *)key withIsPublic:(BOOL)isPublic;

// 删除某一个
- (void)removeLocalStorageItem:(NSString *)key withIsPublic:(BOOL)isPublic ;

// 删除全部
- (void)removeLocalStorageAll:(BOOL)isPublic;

//+ (void)setLocalStorage2:(NSString *)key withValue:(NSString *)value withIsPublic:(BOOL)isPublic;
//+ (NSString *)getLocalStorage2:(NSString *)key withIsPublic:(BOOL)isPublic;
@end
