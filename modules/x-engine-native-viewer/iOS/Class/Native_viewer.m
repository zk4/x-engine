//
//  Native_viewer.m
//  viewer
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer.h"
#import "NativeContext.h"

@interface Native_viewer()
{ }
@end

@implementation Native_viewer
NATIVE_MODULE(Native_viewer)

 - (NSString*) moduleId{
    return @"com.zkty.native.viewer";
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
 
