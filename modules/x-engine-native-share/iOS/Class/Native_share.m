//
//  Native_share.m
//  share
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_share.h"
#import "NativeContext.h"

@interface Native_share()
{ }
@end

@implementation Native_share
NATIVE_MODULE(Native_share)

 - (NSString*) moduleId{
    return @"com.zkty.native.share";
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
 
