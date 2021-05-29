//
//  JSI_viewer.m
//  viewer
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_viewer.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iViewer.h"
#import "CommonCrypto/CommonDigest.h"

@interface JSI_viewer()
@property(nonatomic,strong) id<iViewer> iviewer;

@end

@implementation JSI_viewer
JSI_MODULE(JSI_viewer)

- (void)afterAllJSIModuleInited {
    
    self.iviewer = XENP(iViewer);

}

   
 

- (void)_simpleMethod:(void (^)(BOOL))completionHandler {
    NSLog(@"hello,_simpleMethod");
}

- (void)_simpleMethod {
    NSLog(@"hello,_simpleMethod");
    
}

- (NSString *)_simpleArgMethod:(NSString *)dto {
    return @"from native sync";
}


- (void)_simpleArgMethod:(NSString *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    completionHandler(@"from native async",TRUE);
}

  
- (void)_openFileReader:(_0_com_zkty_jsi_viewer_DTO *)dto complete:(void (^)(StatusDTO *, BOOL))completionHandler {
    
    [self.iviewer openFileWithfileUrl:dto.fileUrl fileType:dto.fileType title:dto.title];
}

- (NSString *)md5EncryptWithString:(NSString *)string {

    if (nil == string || string.length == 0) {
        return nil;
    }
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}

@end
