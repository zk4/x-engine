//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>

#import "iNet.h"
#import "Native_net.h"
#import "GlobalConfigFilter.h"
#import "GlobalServerErrorWithoutCallbackFilter.h"
@interface iOSTests : XCTestCase
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testGet {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    id config = [GlobalConfigFilter new];
    id req = [NSMutableURLRequest new];
    [req addFilter:config];
    [req setURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
    [req send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"error");
        }else{
            NSLog(@"back -> %@",[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
        }
        [expectation fulfill];

    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testGlobal504 {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    id req = [NSMutableURLRequest new];
    [req addFilter:[GlobalConfigFilter new]];
    [req addFilter:[GlobalServerErrorWithoutCallbackFilter new]];
    [req setURL:[NSURL URLWithString:@"https://httpbin.org/status/504"]];
    [req send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 这里不会有回调，错误由全局 GlobalServerErrorWithoutCallbackFilter 拦截处理了。
        NSAssert(FALSE, @"should not be called");
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:5 handler:nil];
}
- (void)testGlobal200 {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    id config = [GlobalConfigFilter new];
    id req = [NSMutableURLRequest new];
    [req addFilter:config];
    [req setURL:[NSURL URLWithString:@"https://httpbin.org/status/200"]];
    [req send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse* hres = (NSHTTPURLResponse*) response;
        NSAssert(hres.statusCode == 200, @"should be 200");
        NSAssert(error == nil, @"should not be error");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:30 handler:nil];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
