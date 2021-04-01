//
//  MicroAppLoader.m
//  AFNetworking
//
//  Created by zk on 2020/8/27.
//

#import "MicroAppLoader.h"
#import "NativeContext.h"

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

- (NSString *)microappDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths lastObject] stringByAppendingPathComponent:@"microapps"];
}

- (void) scanMicroAppsInSandBox{

    NSString * sandbox_microapps_location = [self microappDirectory];
    NSArray* microapps = [MicroAppLoader listFilesInDirectoryAtPath:sandbox_microapps_location deep:false];

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

-(NSString *)getMicroAppHost:(NSString *) moduleIdVersion{
 
    
    NSString * sandbox_microapp_location = [NSString stringWithFormat:@"%@/%@", [self microappDirectory], moduleIdVersion];
    BOOL isDir = false;
    BOOL isEx = [[NSFileManager defaultManager] fileExistsAtPath:sandbox_microapp_location isDirectory:&isDir];
    
    if(!isEx || !isDir){
    
       NSString *htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", moduleIdVersion] ofType:@""];
       if (htmlPath.length > 0) {
           NSString *htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", moduleIdVersion] ofType:@""];
           if (htmlPath) {
                return [NSString stringWithFormat:@"%@/index.html", htmlPath];
           }
       }
    }else{
        NSString * sandbox_microapp_location = [NSString stringWithFormat:@"%@/%@/index.html",[self microappDirectory], moduleIdVersion];
        return sandbox_microapp_location;
    }
    return nil;
}

 

-(NSString *)getMicroAppHost:(NSString *)microAppId withVersion:(long)version{
    return [self getMicroAppHost:[NSString stringWithFormat:@"%@.%ld", microAppId, version]];
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
 
 
@end
