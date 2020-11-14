//
//  XEUniCheckUtil.m
//  x-engine-module-dcloud
//
//  Created by 吕冬剑 on 2020/11/13.
//

#import "XEUniCheckUtil.h"
#import "DCUniMP.h"

@implementation XEUniCheckUtil

+(BOOL)checkUniFile:(NSString *)appId{
    
    return [DCUniMPSDKEngine isExistsApp:appId];
}

+(NSString *)getUniFilePath:(NSString *)appId{
    return [DCUniMPSDKEngine getAppRunPathWithAppid:appId];
}

+(BOOL)copyFileToPath:(NSString *)filePath withAppid:(NSString *)appid{
    return [DCUniMPSDKEngine releaseAppResourceToRunPathWithAppid:appid resourceFilePath:filePath];
}
@end
