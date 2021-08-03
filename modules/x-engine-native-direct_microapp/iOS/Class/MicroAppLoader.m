//
//  MicroAppLoader.m
//  AFNetworking
//
//  Created by zk on 2020/8/27.
//

#import "MicroAppLoader.h"
#import "XENativeContext.h"
#import "iSecurify.h"

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

@interface MicroAppLoader()

@end
@implementation MicroAppLoader

+ (instancetype)sharedInstance{
    static MicroAppLoader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MicroAppLoader alloc] init];
    });
    return sharedInstance;
}
 

- (instancetype)init {
    self = [super init];

    return self;
}

+ (NSArray *)listFilesInDirectoryAtPath:(NSString *)path deep:(BOOL)deep {
    NSArray *listArr;
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    if (deep) {
        // 深遍历
        NSArray *deepArr = [manager subpathsOfDirectoryAtPath:path error:&error];
        if (!error) {
            listArr = deepArr;
        }else {
            listArr = nil;
        }
    }else {
        // 浅遍历
        NSArray *shallowArr = [manager contentsOfDirectoryAtPath:path error:&error];
        if (!error) {
            listArr = shallowArr;
        }else {
            listArr = nil;
        }
    }
    return listArr;
}

- (NSString *)getMicroAppHost:(NSString *)microAppId withVersion:(int)version{
    return [self getMicroAppHost:[NSString stringWithFormat:@"%@.%d", microAppId, version]];
}

- (NSString *)getMicroAppHost:(NSString *)moduleIdVersion {
    NSString *packageInfoPath = [kDocumentPath stringByAppendingPathComponent:moduleIdVersion];
    NSString *path = @"";
    if ([[NSFileManager defaultManager] fileExistsAtPath:packageInfoPath]) {
        path = [NSString stringWithFormat:@"%@/index.html", packageInfoPath];
    } else {
        NSString *rootPath = [[NSBundle mainBundle] pathForResource:@"microapp" ofType:@""];
        NSString *rootMicroappPath = [NSString stringWithFormat:@"%@/%@/index.html", rootPath, moduleIdVersion];
        path = rootMicroappPath;
    }
    return path;
}

- (NSString *)microappDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths lastObject] stringByAppendingPathComponent:@"microapps"];
}
 
-(BOOL)checkMicroAppVersion:(NSString *)microappId version:(long)version{
    
    NSString * sandbox_microapp_location = [NSString stringWithFormat:@"%@/%@.%ld", [self microappDirectory], microappId, version];
    BOOL isDir = false;
    BOOL isEx = [[NSFileManager defaultManager] fileExistsAtPath:sandbox_microapp_location isDirectory:&isDir];
    
    if(!isEx || !isDir){
    
       NSString *htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%ld", microappId, version] ofType:@""];
       if (htmlPath.length > 0) {
            return YES;
       }
    }else{
        return YES;
    }
    return NO;
}


#pragma mark - < json->dic / dic->json >
/**
 *  JSON字符串转NSDictionary
 *  @param jsonString JSON字符串
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}
/**
 *  字典转JSON字符串
 *  @param dic 字典
 *  @return JSON字符串
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


@end
