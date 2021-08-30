//
//  Native_dev.m
//  dev
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

BOOL NATIVE_DEV_DEBUG=TRUE; 
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

- (void)enabledDebug:(BOOL)val{
    NATIVE_DEV_DEBUG = val;
}


- (void)log:(nonnull NSString *)msg {
    if(NATIVE_DEV_DEBUG){
        NSLog(@"hello! DEBUG %@",msg);
    }else{
        NSLog(@"hello! ELSE %@",msg);
    }

}
- (void) xlog:(NSString*) msg{
#ifdef DEBUG
    NSLog(@"DEBUG 宏生效");
#endif
#ifdef RELEASE
    NSLog(@"RELEASE 宏生效");
#endif

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

