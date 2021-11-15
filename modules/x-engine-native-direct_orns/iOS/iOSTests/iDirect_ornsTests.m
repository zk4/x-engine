//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import "iDirect_orns.h"
#import "Native_direct_orns.h"
@interface iOSTests : XCTestCase
@property(nonatomic,strong) id<iDirect_orns> direct_orns;
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _direct_orns = [Native_direct_orns new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString* output = [_direct_orns test];

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
