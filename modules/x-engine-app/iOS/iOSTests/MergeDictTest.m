//
//  MergeDictTest.m
//  MergeDictTest
//
//  Created by zk on 2020/7/22.
//  Copyright © 2020 zk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JSIModule.h>


@interface MergeDictTest : XCTestCase
@property (nonatomic, strong) JSIModule* jsm;

@end

@implementation MergeDictTest

- (void)setUp {
    _jsm = [JSIModule new];
}

- (void)tearDown {
}
  
-(void)testMergeNil {
    NSDictionary* defaultDict = @{@"scheme":@"changed"};
    NSDictionary* srcDict = nil;
    NSDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= @{  @"scheme": @"changed"};
    
    XCTAssertEqualObjects(should,target, @"should equal");
}
-(void)testMergeNil2 {
    NSDictionary* defaultDict = nil;
    NSDictionary* srcDict = @{@"scheme":@"changed"};
    NSDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= @{  @"scheme": @"changed"};
    
    XCTAssertEqualObjects(should,target, @"should equal");
}


-(void)testMergeShallow {
    NSDictionary* defaultDict = @{  @"scheme": @"omp",  @"pathname": @"/"};
    NSDictionary* srcDict = @{@"scheme":@"changed"};
    NSDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= @{  @"scheme": @"changed",  @"pathname": @"/"};
    
    XCTAssertEqualObjects(should,target, @"should equal");
}

-(void)testMergeEmptyWithDepthArg {
    NSDictionary* defaultDict = @{  @"scheme": @"omp",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE,  @"nested":@{
                                                                                                     
    }}};
    NSDictionary* srcDict = @{};
    NSDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= @{  @"scheme": @"omp",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE ,@"nested":@{
                                                                                                
    } }};
    
    XCTAssertEqualObjects(should,target, @"should equal");
}

-(void)testMergeEmptyWithDepthArg1 {
    NSDictionary* defaultDict = @{  @"scheme": @"omp",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE,  @"nested":@{
                                                                                                     @"a":@"b"
    }}};
    NSDictionary* srcDict = @{};
    NSDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= @{  @"scheme": @"omp",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE ,@"nested":@{
                                                                                                @"a":@"b"
    } }};
    
    XCTAssertEqualObjects(should,target, @"should equal");
}
-(void)testMergeEmptyWithDepthArg2 {
    NSDictionary* defaultDict = @{  @"scheme": @"omp",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE,  @"nested":@{
                                                                                                     @"nested":@{
                                                                                                             @"a":@"b"
                                                                                                     },                                                                      @"a":@"b"
    }}};
    NSDictionary* srcDict = @{};
    NSDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= @{  @"scheme": @"omp",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE ,@"nested":@{
                                                                                                @"nested":@{
                                                                                                        @"a":@"b"
                                                                                                },                                      @"a":@"b"
    } }};
    
    XCTAssertEqualObjects(should,target, @"should equal");
}


-(void)testMergeWithDepthArg {
    NSDictionary* defaultDict = @{  @"scheme": @"omp",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE,  @"nested":@{}}};
    NSDictionary* srcDict = @{@"scheme": @"hello"};
    NSDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= [@{  @"scheme": @"hello",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE ,@"nested":@{}}} mutableCopy];
    
    XCTAssertEqualObjects(should,target, @"should equal");
}

-(void)testMergeWithDepthArg1 {
    NSDictionary* defaultDict = @{  @"scheme": @"omp",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE,  @"nested":@{
                                                                                                     @"a":@"b"
    }}};
    NSDictionary* srcDict = @{  @"scheme": @"hello",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE,  @"nested":@{
                                                                                                 @"a":@"c"
}}};
    NSDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= @{  @"scheme": @"hello",  @"pathname": @"/",  @"params": @{    @"hideNavbar": @TRUE,  @"nested":@{
                                                                                                @"a":@"c"
}}};
    XCTAssertEqualObjects(should,target, @"should equal");
}
-(void)testMergeWithDepthArg2 {
    NSDictionary* defaultDict = @{  @"scheme": @"omp",
                                    @"pathname": @"/",
                                    @"params": @{
                                            @"hideNavbar": @TRUE,
                                            @"nested":@{
                                                    @"nested":@{
                                                            @"a":@"b"
                                                            
                                                    },
                                                    @"a":@"b"
                                            }}};
    NSDictionary* srcDict = @{@"nested":@{
                                      @"nested":@{
                                              @"a":@"222"
                                      },
                                      @"a":@"11"
                                      
    }
                              
    };
    NSDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= @{  @"nested":@{
                                       @"nested":@{
                                               @"a":@"222"
                                       },
                                       @"a":@"11"
                                       
     },
                               @"scheme": @"omp",
                               @"pathname": @"/",
                               @"params": @{
                                       @"hideNavbar": @TRUE,
                                       @"nested":@{
                                               @"nested":@{
                                                       @"a":@"b"
                                                       
                                               },
                                               @"a":@"b"
                                       }}};
    
    XCTAssertEqualObjects(should,target, @"should equal");
}
-(void)testMergeWithDepthArg3 {
    NSDictionary* defaultDict = @{@"nested":@{
                                            @"nested":@{
                                                    @"a":@"b"
                                            },
                                            @"a":@"b"
    }};
    NSDictionary* srcDict = @{@"nested":@{
                                      @"nested":@{
                                              @"a":@"222"
                                      },
                                      @"a":@"changed...."
    }};
    NSDictionary*  actual=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSDictionary*  should= @{ @"nested":@{
                                      @"nested":@{
                                              @"a":@"222"
                                      },
                                      @"a":@"changed...."
    } };
    
    XCTAssertEqualObjects(should,actual, @"should equal");
}
-(void)testMergeWithDepthArg4 {
    NSMutableDictionary* defaultDict = [@{  @"nested":@{
                                                    @"nested":@{
                                                            @"a":@"b"
                                                    },
                                                    
    }} mutableCopy];
    NSMutableDictionary* srcDict = [@{@"nested":@{
                                              @"nested":@{
                                                      @"a":@"222"
                                              },
                                              
    }} mutableCopy];
    NSMutableDictionary*  target=[_jsm merge:srcDict defaultDict:defaultDict];
    
    NSMutableDictionary*  should= [@{ @"nested":@{
                                              @"nested":@{
                                                      @"a":@"222"
                                              },
    }} mutableCopy];
    
    XCTAssertEqualObjects(should,target, @"should equal");
}
@end
