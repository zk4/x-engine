//
//  iOSTests.m
//  iOSTests
//

#import <XCTest/XCTest.h>
#import <x-engine-jsi-camera/xengine_jsi_camera.h>
#import <JSONModel.h>

@interface iOSTests : XCTestCase

@end

@implementation iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
 
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    _1_com_zkty_jsi_camera_DTO* ret = [_1_com_zkty_jsi_camera_DTO new];
    NSMutableArray* ret_data = [NSMutableArray new];
    {
        _2_com_zkty_jsi_camera_DTO*  v1= [_2_com_zkty_jsi_camera_DTO new];
        v1.base64thumbnailStr=@"base64";
        v1.tempPath=@"/hahaha/path";
        [ret_data addObject:v1];
    }
    {
        _2_com_zkty_jsi_camera_DTO*  v1= [_2_com_zkty_jsi_camera_DTO new];
        v1.base64thumbnailStr=@"base6422";
        v1.tempPath=@"/hahaha/path222";
        [ret_data addObject:v1];

    ret.data = ret_data;
    
    }

    NSString* s=  [ret toJSONString];
    NSLog(@"%@",s);
    
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
