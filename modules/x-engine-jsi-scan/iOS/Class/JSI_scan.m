//
//  JSI_scan.m
//  scan
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_scan.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "iScan.h"

@interface JSI_scan()
@property(nonatomic,strong) id<iScan> scan;
@end

@implementation JSI_scan
JSI_MODULE(JSI_scan)

- (void)afterAllJSIModuleInited {
    self.scan = XENP(iScan);
}

- (void)textValueFunction:(void(^)(NSString * infor))inforBlock{
    if (inforBlock) {
        inforBlock(@"无返回值的block");
    }
}


- (void)_openScanView:(void (^)(NSString *, BOOL))completionHandler {
//    [self.scan openScanView:^(NSString * resString) {
//        completionHandler(resString, TRUE);
//    }];
}
@end
