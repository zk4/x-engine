//
//  XEZipUtil.h
//  AFNetworking
//
//  Created by 吕冬剑 on 2020/9/24.
//

#import <Foundation/Foundation.h>

@interface XEZipUtil : NSObject

+(BOOL)unZip:(NSString *_Nullable)zipPath withToPath:(NSString *_Nullable)toPath;

+(BOOL)unzipFileAtPath:(NSString * _Nullable)path
         toDestination:(NSString * _Nullable)destination
             overwrite:(BOOL)overwrite
              password:(NSString * _Nullable)password
       progressHandler:(void (^_Nullable)(long entryNumber, long total))progressHandler
     completionHandler:(void (^_Nullable)(NSString * _Nullable path, BOOL succeeded, NSError * _Nullable error))completionHandler;

+(BOOL)toZip:(NSString * _Nullable)zipPath withToPath:(NSString * _Nullable)toPath withProgress:(void(^_Nullable)(NSUInteger, NSUInteger))progress;

@end
