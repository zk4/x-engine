//
//  Url2direct.m
//  Url2direct
//
//  Created by zk on 2020/7/22.
//  Copyright © 2020 zk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <x-engine-jsi-legacy/JSIOldRouterModule.h>
#import <NSString+Router+URLQuery.h>
#import <JSIOldRouterModule.h>


@interface Url2direct : XCTestCase

@end

@implementation Url2direct

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(NSDictionary*) url2DirectModel:(NSString*) url {
    NSString* rawurl = [JSIOldRouterModule SPAUrl2StandardUrl:url];
    NSURL * standardUrl = [NSURL URLWithString:rawurl];
    if(!standardUrl) return Nil;
    return @{
        @"scheme": standardUrl.scheme,
        @"host": standardUrl.host,
        @"pathname": standardUrl.path?standardUrl.path:@"",
        @"fragment": standardUrl.fragment?standardUrl.fragment:@"",
        @"query": standardUrl.query?[rawurl uq_queryDictionary]:@{},
        @"params":@{}
    };
}

- (void)testHttpBaidu {
    NSString* url = @"http://www.baidu.com";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"http",@"host":@"www.baidu.com",@"fragment":@"", @"pathname":@"",@"params":@{},@"query":@{}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}
- (void)testHttps {
    NSString* url = @"https://www.baidu.com";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"", @"pathname":@"",@"params":@{},@"query":@{}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testHttpslash {
    NSString* url = @"https://www.baidu.com/";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"", @"pathname":@"/",@"params":@{},@"query":@{}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testHttpslashPath {
    NSString* url = @"https://www.baidu.com/abc";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"", @"pathname":@"/abc",@"params":@{},@"query":@{}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testHttpslashPathQuery {
    NSString* url = @"https://www.baidu.com/abc?a=a&b=b";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"", @"pathname":@"/abc",@"params":@{},@"query":@{@"a":@"a",@"b":@"b"}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testHttpslashPathQuery2 {
    NSString* url = @"https://www.baidu.com/abc?a=";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"", @"pathname":@"/abc",@"params":@{},@"query":@{@"a":[NSNull null]}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testHttpslashPathQuery3 {
    NSString* url = @"https://www.baidu.com/abc?a";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"", @"pathname":@"/abc",@"params":@{},@"query":@{@"a":[NSNull null]}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testHttpslashPathQueryFragment {
    NSString* url = @"https://www.baidu.com/abc?a=b#";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"", @"pathname":@"/abc",@"params":@{},@"query":@{@"a":@"b"}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testHttpslashPathQueryFragment2 {
    NSString* url = @"https://www.baidu.com/abc?a=b#/";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"/", @"pathname":@"/abc",@"params":@{},@"query":@{@"a":@"b"}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testHttpslashPathQueryFragment3 {
    NSString* url = @"https://www.baidu.com/abc?a=b#/abc";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"/abc", @"pathname":@"/abc",@"params":@{},@"query":@{@"a":@"b"}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}
- (void)testHttpslashPathQueryFragment4 {
    NSString* url = @"https://www.baidu.com/123/abc?a=b#/abc";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"/abc", @"pathname":@"/123/abc",@"params":@{},@"query":@{@"a":@"b"}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testVueHttpPathQueryFragment {
    NSString* url = @"https://www.baidu.com#/abc?a=b";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"/abc", @"pathname":@"",@"params":@{},@"query":@{@"a":@"b"}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}

- (void)testVueHttpslongPathQueryFragment {
    NSString* url = @"https://www.baidu.com/long/path#/abc?a=b";
    NSDictionary* converted = [self url2DirectModel:url];

    NSDictionary*  should= @{@"scheme":@"https",@"host":@"www.baidu.com",@"fragment":@"/abc", @"pathname":@"/long/path",@"params":@{},@"query":@{@"a":@"b"}};
    XCTAssertEqualObjects(should,converted, @"should equal");
}
@end
