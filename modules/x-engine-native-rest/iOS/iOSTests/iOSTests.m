//
//  iOSTests.m
//  iOSTests
//

//#import <XCTest/XCTest.h>
#import "AFTestCase.h"
#import "AFHTTPSessionManager.h"

#import "Native_rest.h"

@interface iOSTests : AFTestCase
@property (readwrite, nonatomic, strong) id<iRest> rest;

@end

@implementation iOSTests


- (void)setUp {
    [super setUp];
    self.rest = [Native_rest new];
}

- (void)tearDown {
    //    [self.sessionManager invalidateSessionCancelingTasks:YES resetSession:NO];
    //    self.sessionManager = nil;
    //    [super tearDown];
}


- (void)testGET {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    [[self.rest session:self.baseURL]
     GET:@"get"
     parameters:nil
     headers:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XCTAssertNotNil(responseObject);
        [expectation fulfill];
    }
     failure:nil];
    [self waitForExpectationsWithCommonTimeout];
}
//
- (void)testHEAD {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    [[self.rest session:self.baseURL]
     HEAD:@"get"
     parameters:nil
     headers:nil
     success:^(NSURLSessionDataTask * _Nonnull task) {
        XCTAssertNotNil(task);
        [expectation fulfill];
    }
     failure:nil];
    [self waitForExpectationsWithCommonTimeout];
}
//
- (void)testPOST {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    [[self.rest session:self.baseURL].requestSerializer setValue:@"default value"
                                              forHTTPHeaderField:@"field"];
    [[self.rest session:self.baseURL]
     POST:@"post"
     parameters:@{@"key":@"value"}
     headers:@{@"field":@"value"}
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XCTAssertTrue([task.originalRequest.allHTTPHeaderFields[@"field"] isEqualToString:@"value"]);
        XCTAssertTrue([responseObject[@"form"][@"key"] isEqualToString:@"value"]);
        [expectation fulfill];
    }
     failure:nil];
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPOSTWithConstructingBody {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    [[self.rest session:self.baseURL].requestSerializer setValue:@"default value"
                                              forHTTPHeaderField:@"field"];
    [[self.rest session:self.baseURL]
     POST:@"post"
     parameters:@{@"key":@"value"}
     headers:@{@"field":@"value"}
     constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:[@"Data" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"DataName"
                                fileName:@"DataFileName"
                                mimeType:@"data"];
    }
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XCTAssertTrue([task.originalRequest.allHTTPHeaderFields[@"field"] isEqualToString:@"value"]);
        XCTAssertTrue([responseObject[@"files"][@"DataName"] isEqualToString:@"Data"]);
        XCTAssertTrue([responseObject[@"form"][@"key"] isEqualToString:@"value"]);
        [expectation fulfill];
    }
     failure:nil];
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPUT {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    [[self.rest session:self.baseURL].requestSerializer setValue:@"default value"
                                              forHTTPHeaderField:@"field"];
    [[self.rest session:self.baseURL]
     PUT:@"put"
     parameters:@{@"key":@"value"}
     headers:@{@"field":@"value"}
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XCTAssertTrue([task.originalRequest.allHTTPHeaderFields[@"field"] isEqualToString:@"value"]);
        XCTAssertTrue([responseObject[@"form"][@"key"] isEqualToString:@"value"]);
        [expectation fulfill];
    }
     failure:nil];
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testDELETE {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
    [[self.rest session:self.baseURL].requestSerializer setValue:@"default value"
                                              forHTTPHeaderField:@"field"];
    [[self.rest session:self.baseURL]
     DELETE:@"delete"
     parameters:@{@"key":@"value"}
     headers:@{@"field":@"value"}
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XCTAssertTrue([task.originalRequest.allHTTPHeaderFields[@"field"] isEqualToString:@"value"]);
        XCTAssertTrue([responseObject[@"args"][@"key"] isEqualToString:@"value"]);
        [expectation fulfill];
    }
     failure:nil];
    [self waitForExpectationsWithCommonTimeout];
}
//
//- (void)testPATCH {
//    XCTestExpectation *expectation = [self expectationWithDescription:@"Request should succeed"];
//    [[self.rest session:self.baseURL].requestSerializer setValue:@"default value"
//                                 forHTTPHeaderField:@"field"];
//    [[self.rest session:self.baseURL]
//     PATCH:@"patch"
//     parameters:@{@"key":@"value"}
//     headers:@{@"field":@"value"}
//     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         XCTAssertTrue([task.originalRequest.allHTTPHeaderFields[@"field"] isEqualToString:@"value"]);
//         XCTAssertTrue([responseObject[@"form"][@"key"] isEqualToString:@"value"]);
//         [expectation fulfill];
//     }
//     failure:nil];
//
//    [self waitForExpectationsWithCommonTimeout];
//}
//
//#pragma mark - Auth
//
- (void)testHiddenBasicAuthentication {
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Request should finish"];
    [[self.rest session:self.baseURL].requestSerializer setAuthorizationHeaderFieldWithUsername:@"user" password:@"password"];
    [[self.rest session:self.baseURL]
     GET:@"hidden-basic-auth/user/password"
     parameters:nil
     headers:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [expectation fulfill];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XCTFail(@"Request should succeed");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithCommonTimeout];
}
//
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    for (int  i=0 ; i<1000;i++){
        [[self.rest session:self.baseURL].requestSerializer setValue:@"default value"
                                                  forHTTPHeaderField:@"field"];
        [[self.rest session:self.baseURL]
         DELETE:@"delete"
         parameters:@{@"key":@"value"}
         headers:@{@"field":@"value"}
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            XCTAssertTrue([task.originalRequest.allHTTPHeaderFields[@"field"] isEqualToString:@"value"]);
            XCTAssertTrue([responseObject[@"args"][@"key"] isEqualToString:@"value"]);
        }
         failure:nil];
    }
    
    
}

-(void) testNew {
    NSString* url =[NSString stringWithFormat:@"%@/delete",self.baseURL];
    NSDictionary* parameters = @{@"key":@"value"};
    NSDictionary* headers =@{@"field":@"value"};
    
    [self measureBlock:^{
        
        for (int  i=0 ; i<1000;i++){
            AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
            [manage DELETE:url parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                XCTAssertTrue([task.originalRequest.allHTTPHeaderFields[@"field"] isEqualToString:@"value"]);
                XCTAssertTrue([responseObject[@"args"][@"key"] isEqualToString:@"value"]);
            } failure:nil];
            
        }
    }];
    
}

-(void) testNewCacheSession {

    [self measureBlock:^{
        
        for (int  i=0 ; i<1000;i++){
            [[self.rest session:self.baseURL]
             DELETE:@"delete"
             parameters:@{@"key":@"value"}
             headers:@{@"field":@"value"}
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                XCTAssertTrue([task.originalRequest.allHTTPHeaderFields[@"field"] isEqualToString:@"value"]);
                XCTAssertTrue([responseObject[@"args"][@"key"] isEqualToString:@"value"]);
            }
             failure:nil];
        }
    }];
    
}
@end
