//
//  Native_store.m
//  store
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

#import "NativeContext.h"
#import "Native_store.h"
#import <UIKit/UIKit.h>

#define X_ENGINE_STORE_KEY @"x-engine-store"
#define JCWeakSelf(type) __weak typeof(type) weak##type = type;
#define JCStrongSelf(type) __strong typeof(type) type = weak##type;

@interface Native_store ()
@property (nonatomic, strong) NSDictionary<NSString *, NSMutableDictionary<NSString *, id> *> *store;
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
        NSMutableDictionary<NSString *, id> *data = [NSMutableDictionary new];
        [data setValue:@"init" forKey:@"init"];
        _store = [NSMutableDictionary new];
        [_store setValue:data forKey:X_ENGINE_STORE_KEY];
    }

    JCWeakSelf(self)
        __block NSMutableDictionary<NSString *, id> *_data;
    _data = [_store objectForKey:X_ENGINE_STORE_KEY];
    [[NSNotificationCenter defaultCenter]
        addObserverForName:UIApplicationDidFinishLaunchingNotification
                    object:nil
                     queue:nil
                usingBlock:^(NSNotification *note) {
                  /// TODO: read store to memory  from sandbox
                  JCStrongSelf(self)
                      NSLog(@" read %@", [_store objectForKey:X_ENGINE_STORE_KEY]);

                  [_data addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:X_ENGINE_STORE_KEY]];

                  NSLog(@"");
                }];

    [[NSNotificationCenter defaultCenter]
        addObserverForName:UIApplicationDidEnterBackgroundNotification
                    object:nil
                     queue:nil
                usingBlock:^(NSNotification *note) {
                  /// TODO: read store to memory  from sandbox
                  NSLog(@"save ");
                  [[NSUserDefaults standardUserDefaults] setObject:[_store objectForKey:X_ENGINE_STORE_KEY] forKey:X_ENGINE_STORE_KEY];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                }];

    return self;
}

- (void)afterAllNativeModuleInited {
}

- (id)get:(NSString *)key {
    return [[_store objectForKey:X_ENGINE_STORE_KEY] objectForKey:key];
}

- (void)set:(NSString *)key val:(id)val {
    [[_store objectForKey:X_ENGINE_STORE_KEY] setObject:val forKey:key];
}

@end
