//
//  JSI_store.m
//  store
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_store.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import <iStore.h>

@interface JSI_store()
@property(nonatomic,strong) id<iStore> store;
@end

@implementation JSI_store
JSI_MODULE(JSI_store)

- (void)afterAllJSIModuleInited {
    self.store = XENP(iStore);
}

 

- (void)_set:(ZKStoreEntryDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [_store set:dto.key val:dto.val];
    completionHandler(TRUE);
}

- (void)_get:(_0_com_zkty_jsi_store_DTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    completionHandler([_store get:dto.key],YES);

}

- (NSString *)_get:(_0_com_zkty_jsi_store_DTO *)dto {
        return [_store get:dto.key];
}


- (id)_set:(ZKStoreEntryDTO *)dto {
    [_store set:dto.key val:dto.val];
    return nil;
}


  
 


@end
