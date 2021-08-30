//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import "iUpdator.h"
#import "Native_updator.h"
@interface iOSTests : XCTestCase
@property(nonatomic,strong) id<iUpdator> updator;
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _updator = [Native_updator new];
    [_updator updateMicroappsFromUrl:@"http://localhost:9527/data.json"];

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
    [_updator updateMicroappsInfos];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
