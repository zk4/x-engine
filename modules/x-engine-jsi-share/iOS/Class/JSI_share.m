//
//  JSI_share.m
//  share
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_share.h"
#import "JSIContext.h"
#import "NativeContext.h"

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

- (NamedDTO *)_namedObject {
    NamedDTO* ret = [NamedDTO new];
    ret.title=@"_namedObject sync";
    ret.titleSize=10000;
    return ret;
}


- (void)_namedObject:(void (^)(NamedDTO *, BOOL))completionHandler {
    NamedDTO* ret = [NamedDTO new];
    ret.title=@"_namedObject async";
    ret.titleSize=10000;
    completionHandler(ret,TRUE);
}


- (_0_com_zkty_jsi_share_DTO *)_nestedAnonymousObject {
    _0_com_zkty_jsi_share_DTO * ret =[_0_com_zkty_jsi_share_DTO new];
    ret.a=@"hello";
    ret.i =[_1_com_zkty_jsi_share_DTO new];
    ret.i.n1=@"_nestedAnonymousObject sync";
    return ret;
}


- (void)_nestedAnonymousObject:(void (^)(_0_com_zkty_jsi_share_DTO *, BOOL))completionHandler {
    _0_com_zkty_jsi_share_DTO * ret =[_0_com_zkty_jsi_share_DTO new];
    ret.a=@"hello";
    ret.i =[_1_com_zkty_jsi_share_DTO new];
    ret.i.n1=@"_nestedAnonymousObject async";
    completionHandler(ret,TRUE);
}

- (NSString *)_simpleArgMethod:(NSString *)dto {
    return @"from native sync";
}


- (void)_simpleArgMethod:(NSString *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    completionHandler(@"from native async",TRUE);
}

 

  
@end
