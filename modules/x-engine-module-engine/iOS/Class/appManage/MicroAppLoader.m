//
//  MicroAppLoader.m
//  AFNetworking
//
//  Created by zk on 2020/8/27.
//

#import "MicroAppLoader.h"

@interface MicroAppLoader()
    @property (nonatomic, strong) NSMutableDictionary *microappId_versionInSandbox;
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
    self.microappId_versionInSandbox = [[NSMutableDictionary alloc] init];
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

+ (NSString *)microappDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths lastObject] stringByAppendingPathComponent:@"microapps"];
}

- (void) scanMicroAppsInSandBox{
    NSString * sandbox_microapps_location = [MicroAppLoader microappDirectory];
    NSArray* microapps = [MicroAppLoader listFilesInDirectoryAtPath:sandbox_microapps_location deep:false];
//    NSArray* microapps2 =
    [MicroAppLoader listFilesInDirectoryAtPath:sandbox_microapps_location deep:YES];
    for (NSString* microapp in microapps){
       NSMutableArray* tokens=[[microapp  componentsSeparatedByString:@"."] mutableCopy];
       NSInteger cur_version =  [[tokens lastObject] intValue];
       [tokens removeLastObject];
       NSString* appid = [tokens componentsJoinedByString:@"."];
       NSNumber* old_version = [self.microappId_versionInSandbox objectForKey:appid];
        if(!old_version || (old_version && [old_version integerValue] < cur_version)){
            [self.microappId_versionInSandbox setObject:[NSNumber numberWithLong:cur_version] forKey:appid];
        }
    }
}

- (NSString*) locateMicroAppByMicroappId:(NSString*)microappId in_version:(long) version{
    self.nowMicroAppId = microappId;
    self.nowMicroAppVersion = version;
    
    NSString * sandbox_microapp_location = [NSString stringWithFormat:@"%@/%@.%ld", [MicroAppLoader microappDirectory], microappId, version];
    BOOL isDir = false;
    BOOL isEx = [[NSFileManager defaultManager] fileExistsAtPath:sandbox_microapp_location isDirectory:&isDir];
    
    if(!isEx || !isDir){
    
       NSString *htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%ld", microappId, version] ofType:@""];
       if (htmlPath.length > 0) {
           NSString *htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%ld", microappId, version] ofType:@""];
           if (htmlPath) {
                return [NSString stringWithFormat:@"file://%@/index.html", htmlPath];
           }
       }
    }else{
        NSString * sandbox_microapp_location = [NSString stringWithFormat:@"file://%@/%@.%ld/index.html",[MicroAppLoader microappDirectory], microappId, version];
        return sandbox_microapp_location;
    }
    
//    BOOL r = [self checkMicroAppVersion:microappId version:version];
//    if(r){
//        NSString * sandbox_microapp_location = [NSString stringWithFormat:@"file://%@/%@.%ld/index.html",[MicroAppLoader microappDirectory], microappId, version];
//        return sandbox_microapp_location;
//    }else{
//       NSString *htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%ld", microappId, version] ofType:@""];
//       if (htmlPath) {
//            return [NSString stringWithFormat:@"file://%@/index.html", htmlPath];
//       }
//    }
    return nil;
}

-(BOOL)checkMicroAppVersion:(NSString *)microappId version:(long)version{
    
    NSString * sandbox_microapp_location = [NSString stringWithFormat:@"%@/%@.%ld", [MicroAppLoader microappDirectory], microappId, version];
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
 
-(NSString *)nowMicroAppId{
    if(_nowMicroAppId == nil){
        return @"temp";
    } else {
        return _nowMicroAppId;
    }
}
 
@end
