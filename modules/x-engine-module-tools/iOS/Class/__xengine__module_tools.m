//
//  xengine__module_tools.m
//  tools
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_tools.h"
#import <XEngineContext.h>
#import "xengine__module_tools.h"
#import <micros.h>
#import "XEZipUtil.h"
#import <x-engine-module-engine/RecyleWebViewController.h>
#import <x-engine-module-engine/Unity.h>

@interface __xengine__module_tools()
@end

@implementation __xengine__module_tools


- (void)_zipFile:(XEZipDTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    
    BOOL r = [XEZipUtil toZip:dto.filePath withToPath:dto.toZipPath withProgress:^(NSUInteger entryNumber, NSUInteger total) {
        UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
        if ([topVC isKindOfClass:[RecyleWebViewController class]]){
            RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
            [webVC runJsFunction:dto.__event__ arguments:@[@((float)entryNumber/(float)total)] completionHandler:nil];
        }
    }];
    completionHandler(r?@"1":@"0", YES);
}

- (void)_unZipFile:(XEUnZipDTO *)dto complete:(void (^)(NSString*, BOOL))completionHandler {
    [XEZipUtil unzipFileAtPath:dto.filePath toDestination:dto.unZipPath overwrite:YES password:nil progressHandler:^(long entryNumber, long total) {
        UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
        if ([topVC isKindOfClass:[RecyleWebViewController class]]){
            RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
            [webVC runJsFunction:dto.__event__ arguments:@[@((float)entryNumber/(float)total)] completionHandler:nil];
        }
    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
        if ([topVC isKindOfClass:[RecyleWebViewController class]]){
            RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
            [webVC runJsFunction:dto.__event__ arguments:@[@(1)] completionHandler:nil];
        }
        completionHandler(error==nil?@"1":@"0", YES);
    }];
}


@end

