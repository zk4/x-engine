//
//  Native_store.m
//  store
//
//  Created by zk on 2020/9/7.

#import "XENativeContext.h"
#import "Native_store.h"
#import <UIKit/UIKit.h>
#import <micros.h>
 
#define X_ENGINE_STORE_KEY @"@@x-engine-store"

@interface Native_store ()
@property (atomic, strong)   NSMutableDictionary<NSString *, id> * store;

@end

@implementation Native_store
NATIVE_MODULE(Native_store)

- (NSString *)moduleId {
    return @"com.zkty.native.store";
}

- (int)order {
    return 0;
}

- (void)afterAllNativeModuleInited {
    
    [self loadFromDisk:FALSE];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _store = [NSMutableDictionary new];
        
        WeakSelf(self)
        [[NSNotificationCenter defaultCenter]
         addObserverForName:UIApplicationDidEnterBackgroundNotification
         object:nil
         queue:nil
         usingBlock:^(NSNotification *note) {
            NSLog(@"save ");
            StrongSelf(self)
            [strongself saveTodisk];
        }];
    }
    
    return self;
}
 
- (id)get:(NSString *)key {

    return [_store objectForKey:key];
}

- (void)set:(NSString *)key val:(id)val {
    if(!val)return;
    [_store setObject:val forKey:key];
}

- (void)del:(NSString*)key{
     [_store removeObjectForKey:key];
}
- (void)delAll{
     [_store removeAllObjects];
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
 
