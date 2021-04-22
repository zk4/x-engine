//
//  JSI_localstorage.m
//  localstorage
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_localstorage.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "iStore.h"
#import "GlobalState.h"


@interface JSI_localstorage()
@property (nonatomic, strong) id<iStore> store;

@end

@implementation JSI_localstorage
JSI_MODULE(JSI_localstorage)

- (void)afterAllJSIModuleInited {
    _store = XENP(iStore);
}


/// 生成 microapp 唯一的 key,现在这个实现对于 omp 来说是有 bug 的. 如果两个微应用来自同一个 host,则会冲突.
/// TODO: 使用真实的 microapp id
/// @param key key
- (NSString *) genkey:(NSString*) key{
    return  [NSString stringWithFormat:@"%@:%@", [[GlobalState sharedInstance] getLastHost], key];
}
- (NSString *)_get:(NSString *)dto {
    return [_store get:[self genkey:dto]];

}
 

- (void)_set:(_0_com_zkty_jsi_localstorage_DTO *)dto {
    [_store set:[self genkey:dto.key] val:dto.val];

}

 
@end
