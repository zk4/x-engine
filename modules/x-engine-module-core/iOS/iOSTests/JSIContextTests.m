//
//  JSIContextTests.m
//  ModuleAppTests
//
//  Created by zk on 2021/3/24.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSIContext.h"
#import "JSIOpenModule.h"

@interface JSIContextTests : XCTestCase

@end

@implementation JSIContextTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testJSIContext_registerModuleByClass {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertThrows([[JSIContext sharedInstance] registerModuleByClass:JSIOpenModule.class]);
    [[JSIContext sharedInstance] start];



}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
