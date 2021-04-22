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
