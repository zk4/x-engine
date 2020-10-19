//
//  XEZipUtil.m
//  AFNetworking
//
//  Created by 吕冬剑 on 2020/9/24.
//

#import "XEZipUtil.h"
#import <SSZipArchive/SSZipArchive.h>

@implementation XEZipUtil

+(BOOL)unZip:(NSString *)zipPath withToPath:(NSString *)toPath{

    return [SSZipArchive unzipFileAtPath:zipPath toDestination:toPath];
}

+(BOOL)unzipFileAtPath:(NSString *)path
         toDestination:(NSString *)destination
             overwrite:(BOOL)overwrite
              password:(NSString *)password
       progressHandler:(void (^)(long entryNumber, long total))progressHandler
     completionHandler:(void (^)(NSString *path, BOOL succeeded, NSError * _Nullable error))completionHandler{

    return [SSZipArchive unzipFileAtPath:path toDestination:destination overwrite:overwrite password:password progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
        if(progressHandler){
            progressHandler(entryNumber, total);
        }
    } completionHandler:completionHandler];
}

+(BOOL)toZip:(NSString *)zipPath withToPath:(NSString *)toPath withProgress:(void(^)(NSUInteger entryNumber, NSUInteger total))progress{
    
    return [SSZipArchive createZipFileAtPath:zipPath
                     withContentsOfDirectory:toPath
                         keepParentDirectory:YES
                                withPassword:nil
                          andProgressHandler:progress];
}

@end
