//
//  iOSTests.m
//  iOSTests
//
//  Created by zk on 2020/7/22.
//  Copyright © 2020 zk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XENativeContext.h"
#import "Native_direct.h"
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
 
    XCTAssertThrows([[XENativeContext sharedInstance] registerModuleByClass:Native_direct.class]);
    [[XENativeContext sharedInstance] start];
 
}
- (void)test获取directmanager_native_Module {

    id openmanager= [[XENativeContext sharedInstance] getModuleById:@"com.zkty.native.direct"];
    XCTAssert(openmanager,@"应该获得 direct manager");
}
- (void)test获取不存在的_native_Module {

    id openmanager= [[XENativeContext sharedInstance] getModuleById:@"com.zkty.native.openmanager.nonexist"];
    XCTAssert(!openmanager,@"应该获得不到 openmanager.nonexist");
}
- (void)testDeleteArrayRange {

NSArray *givenArr = @[@1, @2, @3, @4];
   NSMutableArray *arrM = [NSMutableArray array];
   [arrM addObjectsFromArray:givenArr];
   [arrM removeObjectsInRange:NSMakeRange(arrM.count, 0)];
   NSLog(@"arrM = %@, count = %ld", arrM, arrM.count);
}
@end
