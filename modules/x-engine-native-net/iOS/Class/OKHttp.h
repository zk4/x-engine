//
//  XENetClient.h
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN




typedef void (^ZKRequestCallBack)(id _Nullable result, NSError* _Nullable error);

@interface  iRequest: NSObject
@property (nonatomic,assign) NSString* method;
@property (nonatomic,assign) NSString* scheme;
@property (nonatomic,assign) NSString* baseurl;
@property (nonatomic,assign) NSString* path;
@property (nonatomic,assign) NSDictionary* queries;
@property (nonatomic,assign) NSDictionary* headers;
@property (nonatomic,assign) NSData* rawbody;
//
//// should be get post put
//-(void) method:(NSString*)method;
//-(NSString*) method;
//
//-(void) host:(NSString*)host;
//-(NSString*) host;
//
//-(void) path:(NSString*)path;
//-(NSString*) path;
//
//-(NSDictionary*) queries:(NSDictionary*) queries;
//-(NSDictionary*) queries;
//
//-(void) headers:(NSDictionary*)headers;
//-(NSDictionary*) headers;
//
-(void) setForm:(NSDictionary*) form;
-(NSDictionary*) form;
//
//-(void) rawbody:(NSData*) body;
//-(NSData*) rawbody;

@end

@class AFHTTPSessionManager;
@protocol iInterceptor <NSObject>
    -(NSMutableURLRequest*) intercept:(AFHTTPSessionManager*) af withRequest:(iRequest*) request;
@end



@interface OKHttp : NSObject
-(OKHttp*) build:(iRequest*) request;
-(OKHttp*) send:(ZKRequestCallBack) block;
-(OKHttp*) addInterceptor:(id<iInterceptor>) interceptor;
@end

NS_ASSUME_NONNULL_END
