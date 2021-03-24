//
//  iOSTests.m
//  iOSTests
//
//  Created by zk on 2020/7/22.
//  Copyright © 2020 zk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XEngineContext.h"
@interface iOSTests : XCTestCase

@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_XEngineContext_getModuleById_openmanager_exist {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    id openmanager= [[XEngineContext sharedInstance] getModuleById:@"com.zkty.native.openmanager"];
    XCTAssert(openmanager,@"应该获得 openmanager");
}
- (void)test_XEngineContext_getModuleById_nonexit {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    id openmanager= [[XEngineContext sharedInstance] getModuleById:@"com.zkty.native.openmanager.nonexist"];
    XCTAssert(!openmanager,@"应该获得不到 openmanager.nonexist");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
