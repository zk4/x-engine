//
//  Native_store.m
//  store
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_store.h"
#import "NativeContext.h"

@interface Native_store()
{ }
@end

@implementation Native_store
NATIVE_MODULE(Native_store)

 - (NSString*) moduleId{
    return @"com.zkty.native.store";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
 

- (id)get:(NSString *)key {
    /// TODO: 实现
    return nil;
}

- (void)set:(NSString *)key val:(id)val {
    /// TODO: 实现
}

@end
 
