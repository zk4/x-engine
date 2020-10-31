//
//  MicroAppLoader.m
//  AFNetworking
//
//  Created by zk on 2020/8/27.
//

#import "MicroAppLoader.h"


@interface MicroAppLoader()
    @property (nonatomic, strong) NSMutableDictionary<NSString*,NSString*> *microappId_versionInSandbox;
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
    for (NSString* microapp in microapps){
        NSString * sandbox_microapp_location = [NSString stringWithFormat:@"file://%@/%@/index.html",[MicroAppLoader microappDirectory], microapp];
            [self.microappId_versionInSandbox setObject:sandbox_microapp_location forKey:microapp];
    }
}

- (NSString*) locateMicroAppByMicroappId:(NSString*)microappId in_version:(long) in_version{
    self.nowMicroAppId = microappId;
    NSString* maid_version = [NSString stringWithFormat:@"%@.%ld", microappId, in_version];
    
    // TODO no need to scan every time, only when dirty.
    [self scanMicroAppsInSandBox];
    
    NSString* location_in_sandbox = [self.microappId_versionInSandbox objectForKey:maid_version];
    // found in sand box
    if(location_in_sandbox)
    {
        return location_in_sandbox;
    }
    // otherwise found in project / NSBundle
    else{
       NSString * htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%ld/index",microappId,in_version] ofType:@"html"];
       if (htmlPath) {
           NSString* htmlPathWithShema=[NSString stringWithFormat:@"file://%@", htmlPath];
           [self.microappId_versionInSandbox setObject:htmlPathWithShema forKey:maid_version];
            return htmlPathWithShema;
       }
    }
    return nil;
}
 
 
-(NSString *)nowMicroAppId{
    if(_nowMicroAppId == nil){
        return @"temp";
    } else {
        return _nowMicroAppId;
    }
}
 
@end
