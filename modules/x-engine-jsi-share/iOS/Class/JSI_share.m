//
//  JSI_share.m
//  share
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_share.h"
#import "JSIContext.h"
#import "XENativeContext.h"

@interface JSI_share()
@end

@implementation JSI_share
JSI_MODULE(JSI_share)

- (void)afterAllJSIModuleInited {
}

   
 

- (void)_simpleMethod:(void (^)(BOOL))completionHandler {
    NSLog(@"hello,_simpleMethod");
}

- (void)_simpleMethod {
    NSLog(@"hello,_simpleMethod");
    
}


- (NSString *)_simpleArgMethod:(NSString *)dto {
    return @"from native sync";
}


- (void)_simpleArgMethod:(NSString *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    completionHandler(@"from native async",TRUE);
}

 

  
@end
