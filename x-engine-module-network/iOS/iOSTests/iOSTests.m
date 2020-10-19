//
//  iOSTests.m
//  iOSTests
//
//  Created by edz on 2020/7/22.
//  Copyright © 2020 edz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "__xengine__module_Network.h"

@interface iOSTests : XCTestCase
@property (nonatomic, strong)  __xengine__module_Network *network;
@end

@implementation iOSTests

- (void)setUp {
    _network = [[__xengine__module_Network alloc] init];
}

- (void)testGet {
    [_network GET:@"http://jsonplaceholder.typicode.com/todos/1" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        NSLog(@"GETResponseObject==>:%@", responseObject);
        NSAssert([responseObject[@"id"] integerValue] == 1, @"wocao");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        NSLog(@"GETError===>:%@", error);
    }];
}

- (void)testPost{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"foo" forKey:@"title"];
    [params setValue:@"bar" forKey:@"body"];
    [params setValue:@(1) forKey:@"userId"];
    
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    [params setValue:@"application/json; charset=UTF-8" forKey:@"Content-type"];
    
    [_network POST:@"https://jsonplaceholder.typicode.com/posts" parameters:params headers:header progress:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)testput {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"foo" forKey:@"title"];
    [params setValue:@"bar" forKey:@"body"];
    [params setValue:@(1) forKey:@"userId"];
    [params setValue:@(1) forKey:@"id"];
    
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    [params setValue:@"application/json; charset=UTF-8" forKey:@"Content-type"];
    
    [_network PUT:@"https://jsonplaceholder.typicode.com/posts/1" parameters:params headers:header success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)testPath {
    NSMutableDictionary *putparams = [NSMutableDictionary dictionary];
    [putparams setValue:@"foo" forKey:@"title"];
    
    NSMutableDictionary *putheader = [NSMutableDictionary dictionary];
    [putheader setValue:@"application/json; charset=UTF-8" forKey:@"Content-type"];
    
    [_network PATCH:@"" parameters:putparams headers:putheader success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)testDelete {
    [_network DELETE:@"https://jsonplaceholder.typicode.com/posts/1" parameters:nil headers:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)tearDown {
    sleep(3);
}

- (void)testPerformanceExample {
}
@end

