//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import "iShare_wx.h"
#import "Native_share_wx.h"
@interface iOSTests : XCTestCase
@property(nonatomic,strong) id<iShare_wx> share_wx;
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _share_wx = [Native_share_wx new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString* output = [_share_wx test];

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
