//
//  JSI_vuex.m
//  vuex
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_vuex.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "iStore.h"
#import "GlobalState.h"


@interface JSI_vuex()
@property (nonatomic, strong) id<iStore> store;

@end

@implementation JSI_vuex
JSI_MODULE(JSI_vuex)

- (void)afterAllJSIModuleInited {
    _store = XENP(iStore);
}

/// 生成 microapp 唯一的 key,现在这个实现对于 omp 来说是有 bug 的. 如果两个微应用来自同一个 host,则会冲突.
/// TODO: 使用真实的 microapp id
/// @param key key
- (NSString *) genkey:(NSString*) key{
    assert([[GlobalState sharedInstance] getLastHost]!=nil);
    assert(key!=nil);
    return  [NSString stringWithFormat:@"%@:%@", [[GlobalState sharedInstance] getLastHost], key];
}

- (NSString *)_get:(NSString *)dto {
    NSString* key = [self genkey:dto];
    NSString* ret = [_store get:key];

    return ret;

}

- (void)_set:(_0_com_zkty_jsi_vuex_DTO *)dto {
    [_store set:[self genkey:dto.key] val:dto.val];
}


@end
