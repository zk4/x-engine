////
////  TodoApi.m
////  net
////
////  Created by zk on 2021/9/29.
////  Copyright © 2021 zk. All rights reserved.
////
//
//#import "TodoApi.h"
//#import "GlobalMergeRequestFilter.h"
//#import "GlobalConfigFilter.h"
//#import "GlobalStatusCodeNot2xxFilter.h"
//#import "GlobalJsonFilter.h"
//#import "GlobalNoResponseFilter.h"
//#import "xengine_jsi_undefined.h"
//
//@interface TodoApi()
//
//@end
//
//
//@implementation TodoApi
//- (instancetype)init {
//    if (self = [super init]) {
//    
//    }
//    return self;
//}
// 
//- (NSString*) url{
//    return [NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/todos/%d",self.tid];
//}
//
//- (TodoApi*) request:(TodoApiResponse) todoResponse{
//    self.network = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self url]]];
//    [self.network addFilter:[GlobalConfigFilter sharedInstance]];
//    [self.network addFilter:[GlobalStatusCodeNot2xxFilter sharedInstance]];
//    [self.network addFilter:[GlobalNoResponseFilter sharedInstance]];
//    [self.network addFilter:[GlobalMergeRequestFilter sharedInstance]];
//    [self.network addFilter:[GlobalJsonFilter sharedInstance]];
//    
//    [self.network send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
//        NSDictionary* dict = (NSDictionary*) data;
//        NSError *err;
//        Post* post = [[Post alloc] initWithDictionary:dict error:&err];
//        todoResponse(post,res,err);
//    }];
//    
//    return self;
//}
//@end
