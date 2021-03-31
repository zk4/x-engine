//
//  iOSTests.m
//  iOSTests
//
//  Created by zk on 2020/7/22.
//  Copyright © 2020 zk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <x-engine-jsi-legacy/JSIOldRouterModule.h>



@interface OldRouter2DirectTests : XCTestCase

@end

@implementation OldRouter2DirectTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
 
 

-(void)testNumber {
    XCTAssertEqualObjects(@{@"a":@1}, @{@"a":@1}, @"Not equal.");
}

- (void)testMicroappWithPathQuery {
/// TODO: 数字不能过 value 测试。见：testMicroappWithPathQuery_数字问题
///    NSDictionary*  oldnavdto= @{@"type":@"microapp",@"uri":@"com.gm.microapp.mine",@"path":@"/abc?a=b&c=3",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};

    NSDictionary*  oldnavdto= @{@"type":@"microapp",@"uri":@"com.gm.microapp.mine",@"path":@"/abc?a=b&c=abc",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};
    
    NSDictionary*  should= @{@"scheme":@"microapp",@"host":@"com.gm.microapp.mine" ,@"pathname":@"/abc",@"query":@{@"a":@"b",@"c":@"abc"},@"params":@{@"hideNavbar":@TRUE}};
    
    NSDictionary* converted = [JSIOldRouterModule convertRouter2JSIModel:oldnavdto];
    XCTAssertEqualObjects(should,[JSIOldRouterModule convertRouter2JSIModel:oldnavdto], @"should equal");
}
- (void)testMicroappWithPathQuery_数字问题 {
    NSDictionary*  oldnavdto= @{@"type":@"microapp",@"uri":@"com.gm.microapp.mine",@"path":@"/abc?a=b&c=3",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};

    NSDictionary* converted = [JSIOldRouterModule convertRouter2JSIModel:oldnavdto];
    XCTAssertEqual(3,[converted[@"query"][@"c"] intValue], @"should equal");
}


- (void)testMicroappWithPath {
    
    NSDictionary*  oldnavdto= @{@"type":@"microapp",@"uri":@"com.gm.microapp.mine",@"path":@"/abc",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};

    NSDictionary*  should= @{@"scheme":@"microapp",@"host":@"com.gm.microapp.mine",@"pathname":@"/abc",@"params":@{@"hideNavbar":@TRUE}};
    XCTAssertEqualObjects([JSIOldRouterModule convertRouter2JSIModel:oldnavdto],should, @"should equal");
}
- (void)testMicroappWithPath_中文query参数 {
    
    NSDictionary*  oldnavdto= @{@"type":@"microapp",@"uri":@"com.gm.microapp.mine",@"path":@"/abc?a=我们",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};

    NSDictionary*  should= @{@"scheme":@"microapp",@"host":@"com.gm.microapp.mine",@"pathname":@"/abc",@"params":@{@"hideNavbar":@TRUE},@"query":@{@"a":@"我们"}};
    XCTAssertEqualObjects([JSIOldRouterModule convertRouter2JSIModel:oldnavdto],should, @"should equal");
}
- (void)testMicroappBasic {
    
    NSDictionary*  oldnavdto= @{@"type":@"microapp",@"uri":@"com.gm.microapp.mine",@"path":@"/",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};
    NSDictionary*  should= @{@"scheme":@"microapp",@"host":@"com.gm.microapp.mine",@"pathname":@"/",@"params":@{ @"hideNavbar":@TRUE}};

//    NSString* url2 = @"http://com.gm.microapp.mine.0/index.html#/testA?a=2&b=2";
    XCTAssertEqualObjects([JSIOldRouterModule convertRouter2JSIModel:oldnavdto],should, @"should equal");
}

- (void)testOmp {
    
    NSDictionary*  oldnavdto= @{@"type":@"omp",@"uri":@"http://192.168.1.12",@"path":@"/",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};

    NSDictionary*  should= @{@"scheme":@"omp",@"host":@"192.168.1.12",@"pathname":@"/",@"params":@{ @"hideNavbar":@TRUE}};

//    NSString* url2 = @"http://com.gm.microapp.mine.0/index.html#/testA?a=2&b=2";
    XCTAssertEqualObjects([JSIOldRouterModule convertRouter2JSIModel:oldnavdto],should, @"should equal");
}

 
- (void)testOmp_host多个字符 {
    
    NSDictionary*  oldnavdto= @{@"type":@"omp",@"uri":@"http://192.168.1.12/",@"path":@"/",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};

    NSDictionary*  should= @{@"scheme":@"omp",@"host":@"192.168.1.12",@"pathname":@"/",@"params":@{ @"hideNavbar":@TRUE}};

//    NSString* url2 = @"http://com.gm.microapp.mine.0/index.html#/testA?a=2&b=2";
    XCTAssertEqualObjects([JSIOldRouterModule convertRouter2JSIModel:oldnavdto],should, @"should equal");
}

- (void)testOmp_host多个indexhtml {
    
    NSDictionary*  oldnavdto= @{@"type":@"omp",@"uri":@"http://192.168.1.12/index.html",@"path":@"/",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};

    NSDictionary*  should= @{@"scheme":@"omp",@"host":@"192.168.1.12",@"pathname":@"/",@"params":@{ @"hideNavbar":@TRUE}};

//    NSString* url2 = @"http://com.gm.microapp.mine.0/index.html#/testA?a=2&b=2";
    XCTAssertEqualObjects([JSIOldRouterModule convertRouter2JSIModel:oldnavdto],should, @"should equal");
}
 
- (void)testOmp_path多个indexhtml {
    
    NSDictionary*  oldnavdto= @{@"type":@"omp",@"uri":@"http://192.168.1.12",@"path":@"/index.html",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};

    NSDictionary*  should= @{@"scheme":@"omp",@"host":@"192.168.1.12",@"pathname":@"/index.html",@"params":@{ @"hideNavbar":@TRUE}};

//    NSString* url2 = @"http://com.gm.microapp.mine.0/index.html#/testA?a=2&b=2";
    XCTAssertEqualObjects([JSIOldRouterModule convertRouter2JSIModel:oldnavdto],should, @"should equal");
}


- (void)testOmp_path多个indexhtml_中文query参数 {
   
   NSDictionary*  oldnavdto= @{@"type":@"omp",@"uri":@"http://192.168.1.12",@"path":@"/index.html?a=我们",@"fallback":@"",@"version":@0,@"hideNavbar":@TRUE,@"args":@{}};

    NSDictionary*  should= @{@"scheme":@"omp",@"host":@"192.168.1.12",@"pathname":@"/index.html",@"params":@{ @"hideNavbar":@TRUE},@"query":@{@"a":@"我们"}};

//    NSString* url2 = @"http://com.gm.microapp.mine.0/index.html#/testA?a=2&b=2";
   XCTAssertEqualObjects([JSIOldRouterModule convertRouter2JSIModel:oldnavdto],should, @"should equal");
}
@end
