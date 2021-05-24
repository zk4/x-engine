//
//  Native_dev.m
//  dev
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_dev.h"
#import "XENativeModule.h"
#import "XENativeContext.h"
#import "WHDebugToolManager.h"
#import <micros.h>

@interface Native_dev()
{ }
@end

@implementation Native_dev
NATIVE_MODULE(Native_dev)

- (NSString*) moduleId{
    return @"com.zkty.native.dev";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    
} 

- (void) UIApplicationDidFinishLaunchingNotification {
    [WHDebugToolManager toggleWith:DebugToolTypeAll];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        WeakSelf(self)
        [[NSNotificationCenter defaultCenter]
         addObserverForName:UIApplicationDidFinishLaunchingNotification
         object:nil
         queue:nil
         usingBlock:^(NSNotification *note) {
            StrongSelf(self)
            [self UIApplicationDidFinishLaunchingNotification];
        }];
        
    }
    
    return self;
}
@end

