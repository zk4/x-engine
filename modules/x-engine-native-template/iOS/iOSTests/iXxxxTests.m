//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import "iXxxx.h"
#import "Native_xxxx.h"
@interface iOSTests : XCTestCase
@property(nonatomic,strong) id<iXxxx> xxxx;
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _xxxx = [Native_xxxx new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString* output = [_xxxx test];

    NSString*  should= @"test";

     XCTAssertEqualObjects(output,should, @"should equal");
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
