//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import <x-engine-native-core/NSString+Router+URLQuery.h>


@interface iOSTests : XCTestCase

@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
- (NSString *)judgeQueryWithDict:(NSDictionary<NSString*,id> *)query {
    NSString *finalQueryString = nil;
    if (query) {
        NSArray *keys = query.allKeys;
        NSArray *values = query.allValues;
        NSString *forString = [NSString string];
        for (NSInteger i = 0; i<keys.count; i++) {
            forString = [forString stringByAppendingFormat:@"%@=%@&", keys[i], values[i]];
        }
        if(forString.length > 0){
            NSString *cutString = [forString substringWithRange:NSMakeRange(0, [forString length] - 1)];
            finalQueryString = [NSString stringWithFormat:@"?%@", [cutString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]]];
        }
    }
    return finalQueryString = finalQueryString ? finalQueryString : @"";
}

- (NSString*) convertToVueLikeUrlWithProtocol:(NSString*)protocol host:(NSString*) host pathname:(NSString*)pathname fragment:(NSString*)fragment queryString:(NSDictionary*)queryDict{
    if(!protocol) {
        //TODO
        @throw [NSException exceptionWithName:@"protocol 不存在" reason:@"protocol 不存在" userInfo:nil];
    }
    NSString* queryString =@"";
    if(queryDict){
        queryString =[self judgeQueryWithDict:queryDict];
    }
    
   pathname = pathname ? pathname : @"";
   fragment = fragment ? [NSString stringWithFormat:@"#%@",fragment] : @"";
    
   NSString* finalUrl = [NSString stringWithFormat:@"%@//%@%@%@%@",protocol,host,pathname,fragment,queryString];
    return finalUrl;

}

- (void)testURL1 {
    NSString* protocol = @"http:";
    NSString* host = @"192.168.1.1:3999";
    NSString* pathname   = @"/abc.html";
    NSString* fragment = @"/hello";
    NSDictionary* query = @{@"good":@"我们"};
    NSString* finalUrl = [self convertToVueLikeUrlWithProtocol:protocol host:host pathname:pathname fragment:fragment queryString:query];

    NSString* shouldString =@"http://192.168.1.1:3999/abc.html#/hello?good=%E6%88%91%E4%BB%AC";

    XCTAssertEqualObjects(shouldString,finalUrl, @"should equal");
}

- (void)testURL2 {
    NSString* protocol = @"http:";
    NSString* host = @"192.168.1.1:3999";
    NSString* pathname   = @"/abc.html";
    NSString* fragment = @"/hello";
    NSDictionary* query = nil;
    NSString* finalUrl = [self convertToVueLikeUrlWithProtocol:protocol host:host pathname:pathname fragment:fragment queryString:query];

    NSString* shouldString =@"http://192.168.1.1:3999/abc.html#/hello";

    XCTAssertEqualObjects(shouldString,finalUrl, @"should equal");
}
- (void)testURL3 {
    NSString* protocol = @"http:";
    NSString* host = @"192.168.1.1:3999";
    NSString* pathname   = @"/abc.html";
    NSString* fragment = @"/hello";
    NSDictionary* query = @{@"good":@"abc",@"a":@2};
    NSString* finalUrl = [self convertToVueLikeUrlWithProtocol:protocol host:host pathname:pathname fragment:fragment queryString:query];

    NSString* shouldString =@"http://192.168.1.1:3999/abc.html#/hello?good=abc&a=2";

    XCTAssertEqualObjects(shouldString,finalUrl, @"should equal");
}
- (void)testURL4 {
    NSString* protocol = @"http:";
    NSString* host = @"192.168.1.1:3999";
    NSString* pathname   = @"/abc.html";
    NSString* fragment = nil;
    NSDictionary* query = @{@"good":@"abc",@"a":@2};
    NSString* finalUrl = [self convertToVueLikeUrlWithProtocol:protocol host:host pathname:pathname fragment:fragment queryString:query];

    NSString* shouldString =@"http://192.168.1.1:3999/abc.html?good=abc&a=2";

    XCTAssertEqualObjects(shouldString,finalUrl, @"should equal");
}
- (void)testURL5 {
    NSString* protocol = @"http:";
    NSString* host = @"192.168.1.1:3999";
    NSString* pathname   = nil;
    NSString* fragment = nil;
    NSDictionary* query = @{@"good":@"abc",@"a":@2};
    NSString* finalUrl = [self convertToVueLikeUrlWithProtocol:protocol host:host pathname:pathname fragment:fragment queryString:query];

    NSString* shouldString =@"http://192.168.1.1:3999?good=abc&a=2";

    XCTAssertEqualObjects(shouldString,finalUrl, @"should equal");
}

 @end
