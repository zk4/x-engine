//
//  JSI_globalstorage.m
//  globalstorage
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_globalstorage.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iStore.h"
#import "GlobalState.h"


@interface JSI_globalstorage()
@property (nonatomic, strong) id<iStore> store;
@end

@implementation JSI_globalstorage
JSI_MODULE(JSI_globalstorage)

- (void)afterAllJSIModuleInited {
    _store = XENP(iStore);
}

- (void)_del:(NSString *)dto {
    [_store del:[self genkey:dto]];
}   

- (NSString *)_get:(NSString *)dto {
    return [_store get:[self genkey:dto]];
}

- (void)_set:(_0_com_zkty_jsi_globalstorage_DTO *)dto {
    NSString *key = [NSString stringWithFormat:@"%@", [self genkey:dto.key]];
    NSString *title = [NSString stringWithFormat:@"key: %@ 已存在! 你正在覆盖全局数据! 请调用 del 后再重试.", dto.key];
    if ([_store get:key]) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告!" message:title preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:action];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
        return;
    }
    [_store set:[self genkey:dto.key] val:dto.val];
}

- (NSString *) genkey:(NSString*) key{
    assert(key!=nil);
    return  [NSString stringWithFormat:@"__global__key__%@", key];
}
@end
