//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import <x-engine-module-engine/XEngineJSBUtil.h>
#import "xengine__module_direct_https_insecure.h"
@interface iOSTests : XCTestCase

@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    ContinousDTO * d= [ContinousDTO new];
    NSString* s=[XEngineJSBUtil objToJsonString:d];
    NSLog(@"%@",s);
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
