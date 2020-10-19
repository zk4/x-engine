//
//  xengine__module_microapp.m
//  microapp
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_microapp.h"
#import <XEngineContext.h>
#import <micros.h>
#import "XEZipUtil.h"

@interface __xengine__module_microapp()
@end

@implementation __xengine__module_microapp
 
 

- (void)_install:(XEMicroAppInsertDTO *)dto complete:(void (^)(BOOL))completionHandler {
    NSString *appid = dto.appid;
    NSString *version = dto.version;
    NSString *filePath = dto.filePath;
    NSString *folderName = [NSString stringWithFormat:@"microapps/%@.%@", appid, version];
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [[documentArray lastObject] stringByAppendingPathComponent:folderName];
    
    [XEZipUtil unzipFileAtPath:filePath
                 toDestination:path
                     overwrite:YES
                      password:nil
               progressHandler:nil
             completionHandler:^(NSString *path, BOOL succeeded, NSError * _Nullable error) {
        completionHandler(YES);
    }];
}

-(void)_clearInstallDir:(XEMicroAppInsertDTO *)dto complete:(void (^)(BOOL))completionHandler{
    NSString *appid = dto.appid;
    NSString *version = dto.version;
//    NSString *filePath = dto.filePath;
    NSString *folderName = [NSString stringWithFormat:@"microapps/%@.%@", appid, version];
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [[documentArray lastObject] stringByAppendingPathComponent:folderName];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    completionHandler(YES);
}



@end
 
