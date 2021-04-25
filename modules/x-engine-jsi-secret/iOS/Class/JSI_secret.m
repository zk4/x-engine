//
//  JSI_secret.m
//  secret
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_secret.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "iStore.h"
#import "GlobalState.h"


@interface JSI_secret()
@property (nonatomic, strong) id<iStore> store;

@end

@implementation JSI_secret
JSI_MODULE(JSI_secret)

- (void)afterAllJSIModuleInited {
    _store = XENP(iStore);
}
 
- (NSString *)_get:(NSString *)dto {
    ///TODO: check microapp.json 的权限
    return [_store get:dto];
}
 


@end
