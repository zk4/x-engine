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

   

- (NSString *)_get:(NSString *)dto {
    NSString *customkey = [NSString stringWithFormat:@"%@-%@", [[GlobalState sharedInstance] getLastHost], key];

}

- (void)_get:(NSString *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    <#code#>
}

- (void)_set:(NSString *)dto {
    <#code#>
}

- (void)_set:(NSString *)dto complete:(void (^)(BOOL))completionHandler {
    <#code#>
}

@end
