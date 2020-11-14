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
    if (![DCUniMPSDKEngine isExistsApp:appId]) {
        // 读取导入到工程中的wgt应用资源
    NSString *appResourcePath = [[NSBundle mainBundle] pathForResource:appId ofType:@"wgt"];
        if (!appResourcePath) {
            NSLog(@"资源路径不正确，请检查");
            return NO;
        }
        // 将应用资源部署到运行路径中
        if ([DCUniMPSDKEngine releaseAppResourceToRunPathWithAppid:appId resourceFilePath:appResourcePath]) {
            return YES;
        }
    }
    return YES;
    
}

+(NSString *)getUniFilePath:(NSString *)appId{
    return [DCUniMPSDKEngine getAppRunPathWithAppid:appId];
}

+(BOOL)copyFileToPath:(NSString *)filePath withAppid:(NSString *)appid{
    return [DCUniMPSDKEngine releaseAppResourceToRunPathWithAppid:appid resourceFilePath:filePath];
}
@end
