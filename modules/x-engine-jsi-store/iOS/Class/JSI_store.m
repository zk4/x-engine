//
//  JSI_store.m
//  store
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_store.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iStore.h"

@interface JSI_store()
@property(nonatomic,strong) id<iStore> store;
@end

@implementation JSI_store
JSI_MODULE(JSI_store)

- (void)afterAllJSIModuleInited {
    self.store = XENP(iStore);
}

 
 
  
 


- (NSString *)_get:(NSString *)dto {
    return [_store get:dto];
}

- (void)_get:(NSString *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    completionHandler([_store get:dto],TRUE);
}

- (void)_set:(ZKStoreEntryDTO *)dto {
    [_store set:dto.key val:dto.val];
}

- (void)_set:(ZKStoreEntryDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [_store set:dto.key val:dto.val];
    completionHandler(TRUE);
}

@end
