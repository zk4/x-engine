//
//  Native_store.m
//  store
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

#import "NativeContext.h"
#import "Native_store.h"
#import <UIKit/UIKit.h>
#import <micros.h>
#import "GlobalState.h"
#define X_ENGINE_STORE_KEY @"@@x-engine-store"

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

- (void)afterAllNativeModuleInited {}

- (instancetype)init {
    self = [super init];
    if (self) {
        _store = [NSMutableDictionary new];
        
        WeakSelf(self)
        [[NSNotificationCenter defaultCenter]
         addObserverForName:UIApplicationDidFinishLaunchingNotification
         object:nil
         queue:nil
         usingBlock:^(NSNotification *note) {
            StrongSelf(self)
            [self loadFromDisk:FALSE];
        }];
        WeakSelfNamed(self,1)
        [[NSNotificationCenter defaultCenter]
         addObserverForName:UIApplicationDidEnterBackgroundNotification
         object:nil
         queue:nil
         usingBlock:^(NSNotification *note) {
            NSLog(@"save ");
            StrongSelfNamed(self,1)
            [self saveTodisk];
        }];
    }
    
    return self;
}


// 疑问1
// 怎么判断ios调用还是js调用 通过host有没有值？
// 目前想到的解决方案是的在增加3个方法让原生调用?
// - (id)nativeGet
// - (id)nativeSet
// - (id)nativeDel

// 疑问2
// 下面是拿到host值 拼接的key
// 依赖了x-engine-native-jsi模块 这样是否合适 

- (id)get:(NSString *)key {
    NSString *customkey = [NSString stringWithFormat:@"%@-%@", [[GlobalState sharedInstance] getLastHost], key];
    NSLog(@"%@", customkey);
    return [_store objectForKey:customkey];
}

- (void)set:(NSString *)key val:(id)val {
    NSString *customkey = [NSString stringWithFormat:@"%@-%@", [[GlobalState sharedInstance] getLastHost], key];
    NSLog(@"%@", customkey);
    [_store setObject:val forKey:customkey];
}

- (void)del:(NSString*)key{
    NSString *customkey = [NSString stringWithFormat:@"%@-%@", [[GlobalState sharedInstance] getLastHost], key];
    NSLog(@"%@", customkey);
     [_store removeObjectForKey:customkey];
}

- (void)saveTodisk{
    [[NSUserDefaults standardUserDefaults] setObject:self.store forKey:X_ENGINE_STORE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadFromDisk:(BOOL)merge {
    if(!merge){
        [self.store removeAllObjects];
    }
    [self.store addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:X_ENGINE_STORE_KEY]];
}
@end

#undef X_ENGINE_STORE_KEY
 
