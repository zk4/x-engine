//
//  JSI_xxxx.m
//  xxxx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_xxxx.h"
#import "JSIContext.h"
#import "NativeContext.h"

@interface JSI_xxxx()
@end

@implementation JSI_xxxx
JSI_MODULE(JSI_xxxx)

- (void)afterAllJSIModuleInited {
}



- (NSString *)_syncMethod:(NamedDTO *)dto {
    return [NSString stringWithFormat:@"from native hello:%@", dto.title];
}

- (NSString *)_syncStringMethod:(NSString *)dto {
    NSLog(@"%@",dto);
    return @"native";
}


- (NamedDTO *)_nestedNamedObject {
    NamedDTO* ret = [NamedDTO new];
    ret.title=@"hello";
    ret.titleSize=10000;
    return ret;
}


- (void)_nestedNamedObject:(void (^)(NamedDTO *, BOOL))completionHandler {
    NamedDTO* ret = [NamedDTO new];
    ret.title=@"hello";
    ret.titleSize=10000;
    completionHandler(ret,TRUE);
}

- (_0_com_zkty_jsi_xxxx_DTO *)_nestedObject {
    _0_com_zkty_jsi_xxxx_DTO * ret =[_0_com_zkty_jsi_xxxx_DTO new];
    ret.a=@"hello";
    ret.i =[_1_com_zkty_jsi_xxxx_DTO new];
    ret.i.n1=@"world";
    return ret;
}


- (void)_nestedObject:(void (^)(_0_com_zkty_jsi_xxxx_DTO *, BOOL))completionHandler {
    _0_com_zkty_jsi_xxxx_DTO * ret =[_0_com_zkty_jsi_xxxx_DTO new];
    ret.a=@"hello";
    ret.i =[_1_com_zkty_jsi_xxxx_DTO new];
    ret.i.n1=@"world";
    completionHandler(ret,TRUE);
    
}


- (void)_simpleMethod:(void (^)(BOOL))completionHandler {
    NSLog(@"hello,_syncMethod1");
}

- (void)_simpleMethod {
    NSLog(@"hello,同步方法");
    
}






- (NamedDTO *)_syncRetNestedNamedObject {
    NamedDTO* ret = [NamedDTO new];
    ret.title=@"hello";
    ret.titleSize=10000;
    return ret;
}

- (void)_syncRetNestedNamedObject:(void (^)(NamedDTO *, BOOL))completionHandler {
    NamedDTO* ret = [NamedDTO new];
    ret.title=@"hello";
    ret.titleSize=10000;
    completionHandler(ret,TRUE);
    
}


@end
