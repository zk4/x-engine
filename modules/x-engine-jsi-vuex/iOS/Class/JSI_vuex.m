//
//  JSI_vuex.m
//  vuex
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

//  这个 JSI 模块与 localstorage 区别在于,
//  1. 在 key 上多加了一串值 @@VUEX_STORE_KEY, 为了标明这是一个专为 vuex 存储的 store.
//  2. 广播时只广播当前 microapp.
// TODO: 因为基于了 Native_store, 如果你按 home 退出了. 会持久化 vuex 的状态到本地. 应该去掉这个特性. 不符合 vuex.

#import "JSI_vuex.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iStore.h"
#import "GlobalState.h"

#define VUEX_STORE_KEY @"@@VUEX_STORE_KEY"
#define BROADCAST_EVENT @"@@VUEX_STORE_EVENT"

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
    // 仅对同样的微应用广播
    NSMutableArray<HistoryModel *> *histories= [[GlobalState sharedInstance] getCurrentHostHistories];
    for (HistoryModel* hm in histories){
        if(hm.webview){
            [hm.webview callHandler:@"com.zkty.module.engine.broadcast" arguments:@{
                @"type":BROADCAST_EVENT,
                @"payload":dto.val
            }
             completionHandler:^(id  _Nullable value) {
                NSLog(@"js return value %@",value);
            }];
        }
    }
}


@end
