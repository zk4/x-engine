//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import "iGeo_gaode.h"
#import "Native_geo_gaode.h"
@interface iOSTests : XCTestCase
@property(nonatomic,strong) id<iGeo_gaode> geo_gaode;
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _geo_gaode = [Native_geo_gaode new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    BOOL isSuccess = [_geo_gaode initSDKByConfig:@{@"keyString":@"c68c60fb8801d81927bb6746a93a6fce"}];
    if (isSuccess) {
        [_geo_gaode geoSinglePositionResult:^(NSDictionary *reDic){
            
        }];
    }
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
