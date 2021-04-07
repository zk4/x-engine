//
//  Native_camera.m
//  camera
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_camera.h"
#import "NativeContext.h"

@interface Native_camera()
{ }
@end

@implementation Native_camera
NATIVE_MODULE(Native_camera)

 - (NSString*) moduleId{
    return @"com.zkty.native.camera";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
 
@end
 
