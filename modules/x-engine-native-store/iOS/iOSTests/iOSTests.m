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

 

- (void)testLoadFromDiskMerge {
    [_store set:@"oldkey" val:@"123"];
    [_store saveTodisk];
    [_store set:@"newkey" val:@"abc"];
    [_store loadFromDisk:TRUE];
    NSString* newVal = [_store get:@"newkey"];
    NSString* oldVal = [_store get:@"oldkey"];
    XCTAssertEqualObjects(@"abc",newVal, @"should equal");
    XCTAssertEqualObjects(@"123",oldVal, @"should equal");

}



- (void)testLoadFromDiskDonMerge {
   [_store set:@"oldkey" val:@"123"];
   [_store saveTodisk];
   [_store set:@"newkey" val:@"abc"];
   [_store loadFromDisk:FALSE];
   NSString* newVal = [_store get:@"newkey"];
   NSString* oldVal = [_store get:@"oldkey"];
   XCTAssertEqualObjects(nil,newVal, @"should equal");
   XCTAssertEqualObjects(@"123",oldVal, @"should equal");

}
@end
