//
//  XEZipUtil.h
//  AFNetworking
//
//  Created by 吕冬剑 on 2020/9/24.
//

#import <Foundation/Foundation.h>

@interface XEZipUtil : NSObject

+(BOOL)unZip:(NSString *)zipPath withToPath:(NSString *)toPath;

+(BOOL)unzipFileAtPath:(NSString *)path
         toDestination:(NSString *)destination
             overwrite:(BOOL)overwrite
              password:(NSString *)password
       progressHandler:(void (^)(long entryNumber, long total))progressHandler
     completionHandler:(void (^)(NSString *path, BOOL succeeded, NSError * _Nullable error))completionHandler;

+(BOOL)toZip:(NSString *)zipPath withToPath:(NSString *)toPath withProgress:(void(^)(NSUInteger, NSUInteger))progress;

@end
