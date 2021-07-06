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
@property (nonatomic, strong) XCUIApplication *app;
@property(nonatomic,strong) id<iDirect> nativeDirect;
@property (nonatomic, strong) id<iScan>  nativeScan;
@end

@implementation direct_nativeUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    //关闭应用
    [app terminate];
    //重新启动引用
    [app launch];
    //启动参数
    NSArray *args = [app launchArguments];
    for(int i=0;i<args.count;i++){
        NSLog(@"arg :  %@",[args objectAtIndex:i]);
    }
    //启动环境
    NSDictionary *env = [app launchEnvironment];
    for (id key in env) {
        NSString *object=[env objectForKey:key];
        NSLog(@"env : %@",object);
    }
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    [self.app launch];

    _nativeScan = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iScan)];
    _nativeDirect = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirect)];
    [_nativeDirect registerURLPattern:@"/scan/alert" openNativeActive:^(NSDictionary *routerParameters){
        NSDictionary *dict = routerParameters[@"MGJRouterParameterUserInfo"];
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:[dict[@"key"] stringWithString: @"李焕英"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:action];
        [[Unity sharedInstance].getCurrentVC presentViewController:ac animated:YES completion:nil];

    }];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}
- (void)test带参数路由跳转{
    
    [[[XCUIApplication alloc] init].staticTexts[@"Load Module"] tap];
    [self.nativeDirect push:@"" host:@"" pathname:@"/scan/alert" fragment:@"" query:@"" params:@{@"key":@"value"}];
    
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
