//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import "Native_store.h"
@interface iOSTests : XCTestCase
@property(strong,nonatomic) id<iStore> store;
@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.store = [Native_store new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
- (void)testSetNumber {

    [_store set:@"a" val:@1];
    id a= [_store get:@"a"];
    XCTAssertEqual(1,[a intValue], @"should equal");
}
- (void)testSetDictionary {
    NSDictionary* dict= @{@"a":@"",@"b":[NSNull null],@"dd":@{
        @"cccc":@{
            @"dd":@""
        }
    }};
    [_store set:@"Hello" val:dict];
   id a= [_store get:@"Hello"];
    XCTAssertEqualObjects(dict,a, @"should equal");
}
- (void)testSetNSArray {
    NSArray* array = @[@1,@2,@"hello"];
    [_store set:@"Hello" val:array];
   id a= [_store get:@"Hello"];
    XCTAssertEqualObjects(array,a, @"should equal");
}
 
@end
