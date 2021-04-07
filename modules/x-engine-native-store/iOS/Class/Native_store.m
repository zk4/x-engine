//
//  Native_store.m
//  store
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

#import "NativeContext.h"
#import "Native_store.h"
#import <UIKit/UIKit.h>

#define X_ENGINE_STORE_KEY @"@@x-engine-store"
#define JCWeakSelf(type) __weak typeof(type) weak##type = type;
#define JCStrongSelf(type) __strong typeof(type) type = weak##type;

@interface Native_store ()
@property (nonatomic, strong)   NSMutableDictionary<NSString *, id> * store;
@end

@implementation Native_store
NATIVE_MODULE(Native_store)

- (NSString *)moduleId {
    return @"com.zkty.native.store";
}

- (int)order {
    return 0;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _store = [NSMutableDictionary new];
    }
    
    JCWeakSelf(self)
    [[NSNotificationCenter defaultCenter]
     addObserverForName:UIApplicationDidFinishLaunchingNotification
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) {
        JCStrongSelf(self)
        [self readFromDisk];
    }];
    [[NSNotificationCenter defaultCenter]
     addObserverForName:UIApplicationDidEnterBackgroundNotification
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) {
        NSLog(@"save ");
        JCStrongSelf(self)
        [self saveTodisk];
    }];
    
    return self;
}

- (void)afterAllNativeModuleInited {
}

- (id)get:(NSString *)key {
    return [_store objectForKey:key];
}

- (void)set:(NSString *)key val:(id)val {
    [_store setObject:val forKey:key];
}
- (void) saveTodisk{
    [[NSUserDefaults standardUserDefaults] setObject:self.store   forKey:X_ENGINE_STORE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void) readFromDisk:(BOOL)merge{
    if(!merge){
        [self.store removeAllObjects];
    }
    [self.store addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:X_ENGINE_STORE_KEY]];
}

@end

#undef X_ENGINE_STORE_KEY
#undef JCWeakSelf
#undef JCStrongSelf
