//
//  iOSTests.m
//  iOSTests
//
//  Created by zk on 2020/7/22.
//  Copyright © 2020 zk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XEngineContext.h"
#import "OpenH5Module.h"
@interface XEngineContextTests : XCTestCase

@end

@implementation XEngineContextTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test不可以注册相同的Native_Module {
 
    XCTAssertThrows([[XEngineContext sharedInstance] registerModuleByClass:OpenH5Module.class]);
    [[XEngineContext sharedInstance] start];
 
}
- (void)test获取openmanager_native_Module {

    id openmanager= [[XEngineContext sharedInstance] getModuleById:@"com.zkty.native.openmanager"];
    XCTAssert(openmanager,@"应该获得 openmanager");
}
- (void)test获取不存在的_native_Module {

    id openmanager= [[XEngineContext sharedInstance] getModuleById:@"com.zkty.native.openmanager.nonexist"];
    XCTAssert(!openmanager,@"应该获得不到 openmanager.nonexist");
}

@end
