//
//  JSI_vuex.m
//  vuex
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

//  这个 JSI 模块与 localstorage 唯一的区别在于,在 key 上多加了一串值, 为了标明这是一个 store.


#import "JSI_vuex.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "iStore.h"
#import "GlobalState.h"

#define VUEX_STORE_KEY @"@@VUEX_STORE_KEY"
@interface JSI_vuex()
@property (nonatomic, strong) id<iStore> store;

@end

@implementation JSI_vuex
JSI_MODULE(JSI_vuex)

- (void)afterAllJSIModuleInited {
    _store = XENP(iStore);
}

- (NSString *) genkey:(NSString*) key{
     assert(key!=nil);
     HistoryModel* hm= [[GlobalState sharedInstance] getLastHistory];
     assert(hm!=nil);
     return  [NSString stringWithFormat:@"%@%@%@:%@",VUEX_STORE_KEY, hm.host?hm.host:@"",hm.pathname?hm.pathname:@"", key];
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
