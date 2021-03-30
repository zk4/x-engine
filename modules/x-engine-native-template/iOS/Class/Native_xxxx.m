//
//  Native_xxxx.m
//  xxxx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_xxxx.h"
#import "NativeContext.h"

@interface Native_xxxx()
NATIVE_MODULE(Native_xxxx)
{ }
@end

@implementation Native_xxxx
 
 - (NSString*) moduleId{
    return @"com.zkty.native.xxxx";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
 
@end
 
