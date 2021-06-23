//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import "XENativeContext.h"
#import "iDirect.h"
#import "iScan.h"

@interface iOSTests : XCTestCase
@property(nonatomic,strong) id<iDirect> nativeDirect;
@property (nonatomic, strong) id<iScan>  nativeScan;

@end

@implementation iOSTests

- (void)setUp {
    __weak typeof(self) weakSelf = self;
    _nativeScan = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iScan)];
    _nativeDirect = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirect)];
    [_nativeDirect registerURLPattern:@"mgj://scan/scan" openNativeActive:^{
        weakSelf.nativeScan = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iScan)];
        [weakSelf.nativeScan openScanView:^(NSString *res) {
            NSLog(@"扫码结果 %@",res);
        }];
    }];
}
///实质是测UI(待定)
- (void)testScanRuterJump {
    [self.nativeDirect push:@"" host:@"" pathname:@"mgj://scan/scan" fragment:@"" query:@"" params:@""];
}




@end
