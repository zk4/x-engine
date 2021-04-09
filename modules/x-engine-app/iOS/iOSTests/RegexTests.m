//
//  iOSTests.m
//  iOSTests
//
//  Created by zk on 2020/7/22.
//  Copyright © 2020 zk. All rights reserved.
//

#import <XCTest/XCTest.h>
 


@interface RegexTests : XCTestCase

@end

@implementation RegexTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
 
 

-(void)testMinus1 {
    NSString* string = @"-1";
    NSRange range = [string rangeOfString:@"^-\\d$" options:NSRegularExpressionSearch];
    BOOL matches = range.location != NSNotFound;
    XCTAssertTrue(matches);
}
-(void)testMinus100 {
    NSString* string = @"-100";
    NSRange range = [string rangeOfString:@"^-\\d+$" options:NSRegularExpressionSearch];
    BOOL matches = range.location != NSNotFound;
    XCTAssertTrue(matches);
}
-(void)testNamedHisotyr {
    NSString* string = @"/abc";
    NSRange range = [string rangeOfString:@"^/\\w+$" options:NSRegularExpressionSearch];
    BOOL matches = range.location != NSNotFound;
    XCTAssertTrue(matches);
}
@end
