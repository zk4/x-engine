//
//  Native_viewer_orgi.m
//  viewer_orgi
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer_orgi.h"
#import "NativeContext.h"

@interface Native_viewer_orgi()
{ }
@end

@implementation Native_viewer_orgi
NATIVE_MODULE(Native_viewer_orgi)

 - (NSString*) moduleId{
    return @"com.zkty.native.viewer_orgi";
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
 
