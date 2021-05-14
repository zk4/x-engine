//
//  Native_viewer_orgi.m
//  viewer_orgi
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer_orgi.h"
#import "NativeContext.h"

#import <x-engine-native-store/iStore.h>

@interface Native_viewer_orgi()
{ }
@property (nonatomic, strong) id<iViewer>  viewer;

@end

@implementation Native_viewer_orgi
NATIVE_MODULE(Native_viewer_orgi)
@synthesize defaultState;

 - (NSString*) moduleId{
    return @"com.zkty.native.viewer_orgi";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    NSArray* modules= [[NativeContext sharedInstance]  getModulesByProtocol:@protocol(iViewer)];
     for(id<iViewer> viewer in modules){
         if([[viewer modulName] isEqualToString:@"native.viewer"]){
             self.viewer = viewer;
             return;
         }
     }
}

- (nonnull NSString *)modulName{
    return @"native.viewer_orgi";
}

- (nonnull NSArray *)modulTypeList{
    return  [self.viewer modulTypeList];
}

- (void)setDefaultState:(BOOL)defaultState{
    id<iStore>store = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];
    [store set:[self moduleId] val:[NSNumber numberWithBool:defaultState]];
    [store saveTodisk];
}
- (BOOL)getDefaultState{
    id<iStore>store = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];
    return  [[store get:[self moduleId]] boolValue];
}
- (void)openFileWithfileUrl:(NSString *)url fileType:(NSString *)type callBack:(void(^)(NSString *__nullable filepath))callBack
{
    [self.viewer openFileWithfileUrl:url fileType:type callBack:callBack];
}





@end
 
