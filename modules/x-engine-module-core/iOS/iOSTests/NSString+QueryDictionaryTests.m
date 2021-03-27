//
//  String_QueryDictionaryTests.m
//  UnitTests
//

#import <XCTest/XCTest.h>
#import "NSString+Router+URLQuery.h"

 
static NSString *const uq_URLReservedChars =  @"￼=,!$&'()*+;@?\r\n\"<>#\t :/";

 
 
@interface String_QueryDictionaryTests : XCTestCase
@end

@implementation String_QueryDictionaryTests


//vue-router 标准： http://192.168.1.15:8080/#/testB/?qid=value11111
- (void)testVueRouter {
  NSDictionary *dict = @{@"key":@"value"};
  XCTAssertEqualObjects([@"http://www.foo.com/#/path"
                         uq_URLByAppendingQueryDictionary:dict],
                        @"http://www.foo.com/#/path?key=value",
                        @"Did not create correctly formatted URL");
}
- (void)testVueRouterWithEmptyDict {
  NSDictionary *dict = @{};
  XCTAssertEqualObjects([@"http://www.foo.com/#/path"
                         uq_URLByAppendingQueryDictionary:dict],
                        @"http://www.foo.com/#/path",
                        @"Did not create correctly formatted URL");
}
- (void)testVueRouterWithOnlyKey {
    NSDictionary *dict = @{@"key":@""};
  XCTAssertEqualObjects([@"http://www.foo.com/#/path"
                         uq_URLByAppendingQueryDictionary:dict],
                        @"http://www.foo.com/#/path?key",
                        @"Did not create correctly formatted URL");
}
//
//
- (void)testShouldExtractQueryDictionary {
  NSDictionary *dict = @{@"cat":@"cheese", @"foo":@"bar"};
  XCTAssertEqualObjects(@"http://www.foo.com/?cat=cheese&foo=bar".uq_queryDictionary,
                        dict,
                        @"Did not return correct keys/values");
}
//
- (void)testShouldExtractQueryWithEncodedValues {
  NSDictionary *dict = @{@"翻訳":@"久しぶり"};
  XCTAssertEqualObjects(@"http://www.foo.com/?%E7%BF%BB%E8%A8%B3=%E4%B9%85%E3%81%97%E3%81%B6%E3%82%8A".uq_queryDictionary,
                        dict,
                        @"Did not return correct keys/values");
}
//
- (void)testShouldIgnoreInvalidQueryComponent {
  NSDictionary *dict = @{@"cat":@"cheese"};
  XCTAssertEqualObjects(@"http://www.foo.com/?cat=cheese&invalid=foo=bar".uq_queryDictionary,
                        dict,
                        @"Did not return correct keys/values");
}
//
//
- (void)testShouldAppendWhenURLContainsJustQueryBegin {
    NSDictionary *dict = @{@"key":@"value"};
    XCTAssertEqualObjects([@"http://www.foo.com/path?"
        uq_URLByAppendingQueryDictionary:dict],
    @"http://www.foo.com/path?key=value",
    @"Did not create correctly formatted URL");
}
//
- (void)testShouldAppendToExistingQueryWithFragment {
  NSDictionary *dict = @{@"cat":@"cheese", @"foo":@"bar"};
  XCTAssertEqualObjects([@"http://www.foo.com/?aKey=aValue&another=val2#/fragment" uq_URLByAppendingQueryDictionary:dict],
                        @"http://www.foo.com/#/fragment?aKey=aValue&another=val2&cat=cheese&foo=bar",
                        @"Did not create correctly formatted URL");
}
//
- (void)testShouldSortKeysWithOptionProvided {
  NSDictionary *dict = @{@"xyz":@"bazzle",@"cat":@"cheese", @"foo":@"bar"};
  XCTAssertEqualObjects([@"http://www.foo.com/"
                         uq_URLByAppendingQueryDictionary:dict withSortedKeys:YES],
                        @"http://www.foo.com/?cat=cheese&foo=bar&xyz=bazzle",
                        @"Did not create correctly formatted URL");
}
//
- (void)testShouldEncodeKeysAndValues {
  NSDictionary *dict = @{@"翻訳":@"久しぶり"};
  XCTAssertEqualObjects([@"http://www.foo.com/" uq_URLByAppendingQueryDictionary:dict],
                        @"http://www.foo.com/?%E7%BF%BB%E8%A8%B3=%E4%B9%85%E3%81%97%E3%81%B6%E3%82%8A",
                        @"Did not return correct keys/values");
}
//
- (void)testShouldEncodeValuesContainingReservedCharacters {
    NSDictionary *dict = @{@"q": @"gin & tonic", @"other": uq_URLReservedChars};

    XCTAssertEqualObjects([@"http://www.foo.com/" uq_URLByAppendingQueryDictionary:dict],
    @"http://www.foo.com/?q=gin%20&%20tonic&other=%EF%BF%BC=,!$&'()*+;@?%0D%0A%22%3C%3E%23%09%20:/",
    @"Did not return correct keys/values");
}
//
- (void)testShouldEncodeKeysContainingReservedCharacters {
    NSDictionary *dict = @{ uq_URLReservedChars: @YES};

    XCTAssertEqualObjects([@"http://www.foo.com/" uq_URLByAppendingQueryDictionary:dict],
    @"http://www.foo.com/?%EF%BF%BC=,!$&'()*+;@?%0D%0A%22%3C%3E%23%09%20:/=1",
    @"Did not return correct keys/values");
}
//
- (void)testShouldDealWithEmptyDictionary {
  NSString *urlString = @"http://www.foo.com/?aKey=aValue&another=val2#/fragment";
  NSString *toString = @"http://www.foo.com/#/fragment?aKey=aValue&another=val2";

  XCTAssertEqualObjects([urlString uq_URLByAppendingQueryDictionary:@{}],
                        toString,
                        @"Did not create correctly formatted URL");
}
- (void)testShouldDealWithEmptyDictionary2 {
  NSString *urlString = @"http://www.foo.com/?aKey=aValue&another=val2#fragment";
  NSString *toString = @"http://www.foo.com/#fragment?aKey=aValue&another=val2";

  XCTAssertEqualObjects([urlString uq_URLByAppendingQueryDictionary:@{}],
                        toString,
                        @"Did not create correctly formatted URL");
}
//
- (void)testShouldHandleDictionaryValuesOtherThanStrings {
  NSDictionary *dict = @{@"number":@47, @"date":[NSDate dateWithTimeIntervalSince1970:0]};
  XCTAssertEqualObjects([@"http://www.foo.com/path"
                         uq_URLByAppendingQueryDictionary:dict],
                        @"http://www.foo.com/path?number=47&date=1970-01-01%2000:00:00%20+0000",
                        @"Did not create correctly formatted URL");
}
//
- (void)testShouldHandleDictionaryWithEmptyPropertiesCorrectly {
  NSDictionary *dict = @{ @"key" : @"" };
  XCTAssertEqualObjects([@"http://www.foo.com/"
                         uq_URLByAppendingQueryDictionary:dict],
                        @"http://www.foo.com/?key",
                        @"Did not create correctly formatted URL");
}
//
- (void)testShouldHandleDictionaryWithNullPropertyCorrectly {
  NSDictionary *dict = @{ @"key1" : [NSNull null], @"key2" : @"value" };
  XCTAssertEqualObjects([@"http://www.foo.com/"
                         uq_URLByAppendingQueryDictionary:dict],
                        @"http://www.foo.com/?key1&key2=value",
                        @"Did not create correctly formatted URL");
}
//
- (void)testShouldConvertURLWithEmptyQueryValueToNSNull {
  NSDictionary *dict = @{ @"key" : [NSNull null] };
  XCTAssertEqualObjects(@"http://www.foo.com/?key".uq_queryDictionary,
                        dict,
                        @"Did not return correct keys/values");
}
//
- (void)testShouldHandlePossiblyInvalidURLWithSeparatorButNoValue {
  NSDictionary *dict = @{ @"key1" : [NSNull null], @"key2" : @"value" };
  XCTAssertEqualObjects(@"http://www.foo.com/?key1=&key2=value".uq_queryDictionary,
                        dict,
                        @"Did not return correct keys/values");
}
//
- (void)testShouldConvertURLWithEmptyQueryValueToNSNullWithMultipleKeys {
  NSDictionary *dict = @{ @"key1" : [NSNull null], @"key2" : @"value" };
  XCTAssertEqualObjects(@"http://www.foo.com/?key1&key2=value".uq_queryDictionary,
                        dict,
                        @"Did not return correct keys/values");
}
//
- (void)testShouldCreateURLByRemovingQuery {
    NSString *url = [@"http://www.foo.com/path/?cat=cheese&foo=bar"  uq_URLByRemovingQuery];

    XCTAssertEqualObjects(url,
                        @"http://www.foo.com/path/");
}
//
- (void)testShouldCreateURLByReplacingQueryDictionary {
  NSString *url = @"http://www.foo.com/?cat=cheese&foo=bar";
    NSString *url2 = [url uq_URLByReplacingQueryWithDictionary:@{ @"tree" : @1}];
  XCTAssertEqualObjects(url2, @"http://www.foo.com/?tree=1");
}

@end

 
