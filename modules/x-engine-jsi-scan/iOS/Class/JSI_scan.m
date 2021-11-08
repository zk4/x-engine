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
@end
