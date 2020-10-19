//
//  __xengine__module_localstorage.m
//  AFNetworking
//
//  Created by Chenwuzheng on 2020/8/6.
//

#import "__xengine__module_localstorage.h"
//#import "JSONToDictionary.h"
//#import <micros.h>
#import "XEDataSaveManage.h"

@implementation __xengine__module_localstorage
// 设置
- (void)_setLocalStorage:(StorageSetDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
    
    [XEDataSaveManage setLocalStorage:dto.key withValue:dto.value withIsPublic:dto.isPublic];
    StorageStatusDTO *ret = [StorageStatusDTO new];
    ret.result = @"success";
    completionHandler(ret , YES);
}

// 获取
- (void)_getLocalStorage:(StorageGetDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
    
    StorageStatusDTO *ret = [StorageStatusDTO new];
    ret.result = [XEDataSaveManage getLocalStorage:dto.key withIsPublic:dto.isPublic];
    completionHandler(ret , YES);
}

// 删除某一个
- (void)_removeLocalStorageItem:(StorageRemoveDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
    [XEDataSaveManage removeLocalStorageItem:dto.key withIsPublic:dto.isPublic];
    StorageStatusDTO *ret = [StorageStatusDTO new];
    ret.result = @"success";
    completionHandler(ret , YES);
}

// 删除全部
- (void)_removeLocalStorageAll:(StorageSetDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
    [XEDataSaveManage removeLocalStorageAll];
    StorageStatusDTO *ret = [StorageStatusDTO new];
    ret.result = @"success";
    completionHandler(ret , YES);
}

//- (void)__testGetOtherIDLocalStorage:(StorageGetDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
//    StorageStatusDTO *ret = [StorageStatusDTO new];
//    ret.result = [XEDataSaveManage getLocalStorage2:dto.key withIsPublic:dto.isPublic];
//    completionHandler(ret , YES);
//}
//
//
//- (void)__testSetOtherIDLocalStorage:(StorageSetDTO *)dto complete:(void (^)(StorageStatusDTO *, BOOL))completionHandler {
//    [XEDataSaveManage setLocalStorage2:dto.key withValue:dto.value withIsPublic:dto.isPublic];
//    StorageStatusDTO *ret = [StorageStatusDTO new];
//    ret.result = @"success";
//    completionHandler(ret , YES);
//}



@end
