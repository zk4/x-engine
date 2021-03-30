//
//  Native_ui.m
//  ui
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_ui.h"
#import "NativeContext.h"

@interface Native_ui()
NATIVE_MODULE(Native_ui)
{ }
@end

@implementation Native_ui
 
 - (NSString*) moduleId{
    return @"com.zkty.native.ui";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
 
@end
 
