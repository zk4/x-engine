//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import "iLocalstorage__webproxy.h"
#import "Native_localstorage__webproxy.h"
@interface iOSTests : XCTestCase
@property(nonatomic,strong) id<iLocalstorage__webproxy> localstorage__webproxy;
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _localstorage__webproxy = [Native_localstorage__webproxy new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    NSURL* url =[NSURL URLWithString:@"http://192.1.6.1.:8000/index.html"];
    if ([[url path] length] > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    NSLog(@"%@",url);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
