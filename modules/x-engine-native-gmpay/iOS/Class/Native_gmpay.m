//
//  Native_gmpay.m
//  gmpay
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_gmpay.h"
#import "NativeContext.h"

@interface Native_gmpay()
{ }
@end

@implementation Native_gmpay
NATIVE_MODULE(Native_gmpay)

 - (NSString*) moduleId{
    return @"com.zkty.native.gmpay";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
 
@end
 
