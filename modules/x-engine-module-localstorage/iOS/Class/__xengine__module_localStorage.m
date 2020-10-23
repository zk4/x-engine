//
//  __xengine__module_localstorage.m
//  AFNetworking
//
//  Created by Chenwuzheng on 2020/8/6.
//

#import "__xengine__module_localstorage.h"
 
#import "XEDataSaveManage.h"

@implementation __xengine__module_localstorage


- (void)_get:(StorageGetDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
    StorageStatusDTO *ret = [StorageStatusDTO new];
    ret.result = [XEDataSaveManage getLocalStorage:dto.key withIsPublic:dto.isPublic];
    completionHandler(ret , YES);
}

- (void)_remove:(StorageRemoveDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
    [XEDataSaveManage removeLocalStorageItem:dto.key withIsPublic:dto.isPublic];
    StorageStatusDTO *ret = [StorageStatusDTO new];
    ret.result = @"success";
    completionHandler(ret , YES);
}

- (void)_removeAll:(StorageRemoveAllDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
    [XEDataSaveManage removeLocalStorageAll:dto.isPublic];
    StorageStatusDTO *ret = [StorageStatusDTO new];
    ret.result = @"success";
    completionHandler(ret , YES);
}

- (void)_set:(StorageSetDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
    [XEDataSaveManage setLocalStorage:dto.key withValue:dto.value withIsPublic:dto.isPublic];
    StorageStatusDTO *ret = [StorageStatusDTO new];
    ret.result = @"success";
    completionHandler(ret , YES);
}

@end
