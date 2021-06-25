//
//  JSI_geo.m
//  geo
//


#import "JSI_geo.h"
#import "JSIContext.h"
#import "XENativeContext.h"

@interface JSI_geo()
@end

@implementation JSI_geo
JSI_MODULE(JSI_geo)

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


- (_0_com_zkty_jsi_geo_DTO *)_nestedAnonymousObject {
    _0_com_zkty_jsi_geo_DTO * ret =[_0_com_zkty_jsi_geo_DTO new];
    ret.a=@"hello";
    ret.i =[_1_com_zkty_jsi_geo_DTO new];
    ret.i.n1=@"_nestedAnonymousObject sync";
    return ret;
}


- (void)_nestedAnonymousObject:(void (^)(_0_com_zkty_jsi_geo_DTO *, BOOL))completionHandler {
    _0_com_zkty_jsi_geo_DTO * ret =[_0_com_zkty_jsi_geo_DTO new];
    ret.a=@"hello";
    ret.i =[_1_com_zkty_jsi_geo_DTO new];
    ret.i.n1=@"_nestedAnonymousObject async";
    completionHandler(ret,TRUE);
}

- (NSString *)_simpleArgMethod:(NSString *)dto {
    return @"from native sync";
}


- (void)_simpleArgMethod:(NSString *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    completionHandler(@"from native async",TRUE);
}
 

- (NSInteger)_simpleArgNumberMethod:(NSInteger)dto {
    return dto;
}


- (void)_simpleArgNumberMethod:(NSInteger)dto complete:(void (^)(NSInteger, BOOL))completionHandler {
    completionHandler(dto,TRUE);
}


 

  
@end
