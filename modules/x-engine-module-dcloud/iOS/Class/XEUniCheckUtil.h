//
//  XEUniCheckUtil.h
//  x-engine-module-dcloud
//
//  Created by 吕冬剑 on 2020/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XEUniCheckUtil : NSObject

+(BOOL)checkUniFile:(NSString *)appId;
+(NSString *)getUniFilePath:(NSString *)appId;
+(BOOL)copyFileToPath:(NSString *)filePath withAppid:(NSString *)appid;

@end

NS_ASSUME_NONNULL_END
