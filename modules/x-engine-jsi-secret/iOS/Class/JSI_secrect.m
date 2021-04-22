//
//  JSI_secrect.m
//  secrect
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_secrect.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "iStore.h"
#import "GlobalState.h"


@interface JSI_secrect()
@property (nonatomic, strong) id<iStore> store;

@end

@implementation JSI_secrect
JSI_MODULE(JSI_secrect)

- (void)afterAllJSIModuleInited {
    _store = XENP(iStore);
}
 
- (NSString *)_get:(NSString *)dto {
    ///TODO: check microapp.json 的权限
    return [_store get:dto];
}
 


@end
