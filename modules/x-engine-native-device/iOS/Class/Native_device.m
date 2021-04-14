//
//  Native_device.m
//  device
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_device.h"
#import "NativeContext.h"

@interface Native_device()
@end

@implementation Native_device
NATIVE_MODULE(Native_device)

 - (NSString*) moduleId{
    return @"com.zkty.native.device";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
}



- (NSString*) getNavigationHeight {
    return @"hello";
}

@end
 
