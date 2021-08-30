//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import "iScan__hms.h"
#import "Native_scan__hms.h"
@interface iOSTests : XCTestCase
@property(nonatomic,strong) id<iScan__hms> scan__hms;
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _scan__hms = [Native_scan__hms new];
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
