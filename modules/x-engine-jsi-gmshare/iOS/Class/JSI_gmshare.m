//
//  JSI_gmshare.m
//  gmshare
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_gmshare.h"
#import "JSIContext.h"
#import "XENativeContext.h"

@interface JSI_gmshare()
@end

@implementation JSI_gmshare
JSI_MODULE(JSI_gmshare)

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
