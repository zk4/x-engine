//
//  Native_viewer_original.m
//  viewer_original
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer_original.h"
#import "XENativeContext.h"

@interface Native_viewer_original()
{ }
@end

@implementation Native_viewer_original
NATIVE_MODULE(Native_viewer_original)

 - (NSString*) moduleId{
    return @"com.zkty.native.viewer_original";
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
 
