//
//  Native_networkmanager.m
//  networkmanager
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_networkmanager.h"
#import "XENativeContext.h"

@interface Native_networkmanager()
{ }
@end

@implementation Native_networkmanager
NATIVE_MODULE(Native_networkmanager)

 - (NSString*) moduleId{
    return @"com.zkty.native.networkmanager";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
-(NSString*) test{
    return @"test";
}
@end
 
