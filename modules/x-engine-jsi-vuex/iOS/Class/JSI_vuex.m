//
//  JSI_vuex.m
//  vuex
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

//  这个 JSI 模块与 localstorage 唯一的区别在于,在 key 上多加了一串值 @@VUEX_STORE_KEY, 为了标明这是一个专为 vuex 存储的 store.
//  这也带一些特性.. 即使你退出了.. 也能保持 vue 的状态.


#import "JSI_vuex.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "iStore.h"
#import "iBroadcast.h"
#import "GlobalState.h"

#define VUEX_STORE_KEY @"@@VUEX_STORE_KEY"
#define BROADCAT_EVENT @"VUEX_STORE_EVENT"

@interface JSI_vuex()
@property (nonatomic, strong) id<iStore> store;
@property (nonatomic, strong)   id<iBroadcast>  broadcast;

@end

@implementation JSI_vuex
JSI_MODULE(JSI_vuex)

- (void)afterAllJSIModuleInited {
    _store = XENP(iStore);
    _broadcast = XENP(iBroadcast);
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
    [_broadcast broadcast:BROADCAT_EVENT payload:dto.val];
}


@end
