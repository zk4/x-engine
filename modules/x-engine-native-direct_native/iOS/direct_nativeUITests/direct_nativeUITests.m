//
//  direct_nativeUITests.m
//  direct_nativeUITests
//
//  Created by jabraknight on 2021/6/23.
//  Copyright © 2021 zk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "iDirect.h"
#import "iScan.h"
#import "Unity.h"
#import "XENativeContext.h"

@interface direct_nativeUITests : XCTestCase
@property(nonatomic,strong) id<iDirect> nativeDirect;
@property (nonatomic, strong) id<iScan>  nativeScan;
@end

@implementation direct_nativeUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    __weak typeof(self) weakSelf = self;
    _nativeScan = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iScan)];
    _nativeDirect = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirect)];
    [_nativeDirect registerURLPattern:@"mgj://scan/scan" openNativeActive:^{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"与啊谁呢好难过" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:action];
        [[Unity sharedInstance].getCurrentVC presentViewController:ac animated:YES completion:nil];
    }];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}
///实质是测UI(待定)
- (void)test跳原生页面 {
    [self.nativeDirect push:@"" host:@"" pathname:@"mgj://scan/scan" fragment:@"" query:@"" params:@""];
}
- (void)test点击 {
    
}
- (void)testExample {
            
    // UI tests must launch the application that they test.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[[[XCTApplicationLaunchMetric alloc] init]] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
