//
//  JSI_scan.m
//  scan
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 x-engine. All rights reserved.


#import "JSI_scan.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iScan.h"

@interface JSI_scan()
@property(nonatomic,strong) id<iScan> scan;
@end

@implementation JSI_scan
JSI_MODULE(JSI_scan)

- (void)afterAllJSIModuleInited {
    self.scan = XENP(iScan);
}

- (void)_openScanView:(void (^)(NSString *, BOOL))completionHandler {
    [self.scan openScanView:^(NSString * res) {
        completionHandler(res, true);
    }];
}
- (void) _openScanView:(_openScanView_com_zkty_jsi_scan_0_DTO*) dto complete:(void (^)(NSString* result,BOOL complete)) completionHandler{
    
    if(dto && dto.routerUrl && dto.routerUrl.length>0) {

        [self.scan openScanView:dto.routerUrl complete:^(NSString *res) {
            completionHandler(res, true);
        }];
    }else{
        [self.scan openScanView:^(NSString * res) {
            completionHandler(res, true);
        }];
    
    }
    
}
@end
