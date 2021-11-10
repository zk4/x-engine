//
//  JSI_rn_direct.m
//  rn_direct
//
// Copyright (c) 2021 x-engine
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE./


#import "JSI_rn_direct.h"
#import "JSIContext.h"
#import "XENativeContext.h"

@interface JSI_rn_direct()
@end

@implementation JSI_rn_direct
JSI_MODULE(JSI_rn_direct)

- (void)afterAllJSIModuleInited {
}

   
//
//
//- (void)_simpleMethod:(void (^)(BOOL))completionHandler {
//    NSLog(@"hello,_simpleMethod");
//}
//
//- (void)_simpleMethod {
//    NSLog(@"hello,_simpleMethod");
//
//}
//
//- (NamedDTO *)_namedObject {
//    NamedDTO* ret = [NamedDTO new];
//    ret.title=@"_namedObject sync";
//    ret.titleSize=10000;
//    return ret;
//}
//
//
//- (void)_namedObject:(void (^)(NamedDTO *, BOOL))completionHandler {
//    NamedDTO* ret = [NamedDTO new];
//    ret.title=@"_namedObject async";
//    ret.titleSize=10000;
//    completionHandler(ret,TRUE);
//}
//
//
//- (_0_com_zkty_jsi_rn_direct_DTO *)_nestedAnonymousObject {
//    _0_com_zkty_jsi_rn_direct_DTO * ret =[_0_com_zkty_jsi_rn_direct_DTO new];
//    ret.a=@"hello";
//    ret.i =[_1_com_zkty_jsi_rn_direct_DTO new];
//    ret.i.n1=@"_nestedAnonymousObject sync";
//    return ret;
//}
//
//
//- (void)_nestedAnonymousObject:(void (^)(_0_com_zkty_jsi_rn_direct_DTO *, BOOL))completionHandler {
//    _0_com_zkty_jsi_rn_direct_DTO * ret =[_0_com_zkty_jsi_rn_direct_DTO new];
//    ret.a=@"hello";
//    ret.i =[_1_com_zkty_jsi_rn_direct_DTO new];
//    ret.i.n1=@"_nestedAnonymousObject async";
//    completionHandler(ret,TRUE);
//}
//
//- (NSString *)_simpleArgMethod:(NSString *)dto {
//    return @"from native sync";
//}
//
//
//- (void)_simpleArgMethod:(NSString *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
//    completionHandler(@"from native async",TRUE);
//}
//
//
//- (NSInteger)_simpleArgNumberMethod:(NSInteger)dto {
//    return dto;
//}
//
//
//- (void)_simpleArgNumberMethod:(NSInteger)dto complete:(void (^)(NSInteger, BOOL))completionHandler {
//    completionHandler(dto,TRUE);
//}
//

 

 
- (_complexAnoymousRetWithAnoymousArgs0_DTO *)_complexAnoymousRetWithAnoymousArgs:(_complexAnoymousRetWithAnoymousArgs3_DTO *)dto {
  [_complexAnoymousRetWithAnoymousArgs3_DTO new];
    NSString* retstr= [dto toJSONString];
    _complexAnoymousRetWithAnoymousArgs0_DTO* ret =  [[_complexAnoymousRetWithAnoymousArgs0_DTO alloc] initWithString:retstr error:nil];
    return ret;
}

- (void)_complexAnoymousRetWithAnoymousArgs:(_complexAnoymousRetWithAnoymousArgs3_DTO *)dto complete:(void (^)(_complexAnoymousRetWithAnoymousArgs0_DTO *, BOOL))completionHandler {
    completionHandler([self _complexAnoymousRetWithAnoymousArgs:dto],TRUE);
}
 
- (NSInteger)_simpleArgNumberMethod:(NSInteger)dto {
    return dto;
}


- (void)_simpleArgNumberMethod:(NSInteger)dto complete:(void (^)(NSInteger, BOOL))completionHandler {
    completionHandler(dto,TRUE);
}
 

@end
