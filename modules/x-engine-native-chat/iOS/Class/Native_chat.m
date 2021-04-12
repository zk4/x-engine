//
//  Native_chat.m
//  chat
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_chat.h"
#import "NativeContext.h"

@interface Native_chat()
{ }
@end

@implementation Native_chat
NATIVE_MODULE(Native_chat)

 - (NSString*) moduleId{
    return @"com.zkty.native.chat";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
 
@end
 
