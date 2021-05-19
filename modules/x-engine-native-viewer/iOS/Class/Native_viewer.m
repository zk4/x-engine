//
//  Native_viewer.m
//  viewer
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer.h"
#import "NativeContext.h"

#import "AFNetworking.h"
#import "iViewer.h"
#import <x-engine-native-store/iStore.h>

@interface Native_viewer()
{ }
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iViewer>> * viewers;
@property (nonatomic, strong) id<iViewer>iviewer;

@property (nonatomic, strong) id<iStore>store;

@end

@implementation Native_viewer
NATIVE_MODULE(Native_viewer)

- (NSString*) moduleId{
    return @"com.zkty.native.viewer";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    self.store = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];
}

- (void)setDefaultState:(BOOL)defaultState
{
    [self.iviewer setDefaultState:defaultState];
}

- (BOOL)getDefaultState
{
    return [self.iviewer getDefaultState];
}

- (nonnull NSArray *)openFileTypeList
{
    return  [self.iviewer openFileTypeList];
}

- (void)openFileWithfileUrl:(NSString *_Nonnull)url fileType:(NSString *_Nonnull)type callBack:(void(^_Nullable)(NSString *__nullable filepath))callBack;
{
    [self.iviewer openFileWithfileUrl:url fileType:type callBack:callBack];
}

@end
 
