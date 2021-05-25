//
//  Native_network.m
//  network
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_network.h"
#import "NativeContext.h"

@interface Native_network()
{ }
@end

@implementation Native_network
NATIVE_MODULE(Native_network)

 - (NSString*) moduleId{
    return @"com.zkty.native.network";
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
 
