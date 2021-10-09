//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>

#import "iKONet.h"
#import "Native_net.h"
#import "GlobalConfigFilter.h"
#import "GlobalStatusCodeNot2xxFilter.h"
#import "GlobalMergeRequestFilter.h"
#import "GlobalNoResponseFilter.h"
#import "NSMutableURLRequest+Filter.h"
#import "x_api_ParameterInUrl.h"
@interface iOSTests : XCTestCase
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [KOBaseApi ko_configPipelineByName:@"HTTPBIN" pipeline:({
        id pipeline =  [NSMutableArray new];
        [pipeline addObject:[GlobalConfigFilter sharedInstance]];
        [pipeline addObject:[GlobalMergeRequestFilter sharedInstance]];
        [pipeline addObject:[GlobalStatusCodeNot2xxFilter sharedInstance]];
        [pipeline addObject:[GlobalNoResponseFilter sharedInstance]];
        pipeline;
    })];
    
    
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
    [req addFilter:[GlobalStatusCodeNot2xxFilter new]];
    [req setURL:[NSURL URLWithString:@"https://httpbin.org/status/504"]];

    [req send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 这里不会有回调，错误由全局 GlobalStatusCodeNot2xxFilter 拦截处理了。
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



- (void)testParameterInUrl {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    ParameterInUrlReq * req = [ParameterInUrlReq new];
    x_api_ParameterInUrl *api = [x_api_ParameterInUrl new];
    [api setLocalUrlPrefix:@"https://httpbin.org"];
    [api activePipelineByName:@"HTTPBIN"];
    [[[api promise:req] then:^id _Nullable(ParameterInUrlRes * _Nullable value) {
            [expectation fulfill];
            return nil;
        }]
    catch:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:30 handler:nil];
}
- (void)testParameterInUrlWithRaw {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];

    id req = [NSMutableURLRequest new];
    [req activePipelineByName:@"HTTPBIN"];
    [req setURL:[NSURL URLWithString:@"https://httpbin.org/bytes/4"]];
    [req send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 这里不会有回调，错误由全局 GlobalStatusCodeNot2xxFilter 拦截处理了。
        NSLog(@"%@",response);
    }];

    [self waitForExpectationsWithTimeout:5 handler:nil];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
