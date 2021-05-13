//
//  Native_viewer-orgi.m
//  viewer-orgi
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer-orgi.h"
#import "NativeContext.h"

@interface Native_viewer-orgi()
{ }
@end

@implementation Native_viewer-orgi
NATIVE_MODULE(Native_viewer-orgi)

 - (NSString*) moduleId{
    return @"com.zkty.native.viewer-orgi";
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
 
