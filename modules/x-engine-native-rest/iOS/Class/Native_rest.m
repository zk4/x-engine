//
//  Native_rest.m
//  rest
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_rest.h"
#import "XENativeContext.h"
#import "AFHTTPSessionManager.h"

@interface Native_rest()
    @property (readwrite, nonatomic, strong) NSMutableDictionary<NSURL*, AFHTTPSessionManager*> *sessionManagers;

@end

@implementation Native_rest
NATIVE_MODULE(Native_rest)

 - (NSString*) moduleId{
    return @"com.zkty.native.rest";
}

- (int) order{
    return 0;
}
- (instancetype)init
{
    self = [super init];
    if(self){
        self.sessionManagers = [NSMutableDictionary new];
    }
    return self;
}


- (void)afterAllNativeModuleInited{
} 
 
- (AFHTTPSessionManager *)session:(NSURL *)baseUrl{
    AFHTTPSessionManager* sessionManager = [self.sessionManagers objectForKey:baseUrl];

    /// TODO: 同步
    if(!sessionManager){
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        [self.sessionManagers setObject:sessionManager forKey:baseUrl];
    }
    return sessionManager;
}
@end
 
