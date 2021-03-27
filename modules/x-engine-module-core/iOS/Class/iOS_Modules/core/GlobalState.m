//
//  GlobalState.m
//  ModuleApp
//
//  Created by zk on 2021/3/27.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "GlobalState.h"
#import "HistoryModel.h"
@interface GlobalState()
@property(nonatomic,strong) NSMapTable<id,NSMutableArray<HistoryModel*>*>* wv__vc_paths;

@end
@implementation GlobalState
static NSString*  s_microapp_root_url;
static XEngineWebView*  s_showing_webview;


- (instancetype)init {
   self = [super init];
   self.wv__vc_paths = [NSMapTable new];
   return self;
}


+ (instancetype)sharedInstance {
    static GlobalState *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];

    });
    return sharedInstance;
}

+ (NSString * _Nullable) s_microapp_root_url{
    return s_microapp_root_url;
}
+ (void) set_s_microapp_root_url:(NSString*)val{
      s_microapp_root_url=val;
}
+ (void)setCurrentWebView:(XEngineWebView*) val{
    if(s_showing_webview)
        s_showing_webview=nil;
    s_showing_webview=val;
}
+ (XEngineWebView*)getCurrentWebView{
    return s_showing_webview;
}
- (void)deleteWebView:(XEngineWebView *) webview{
}
- (NSMutableArray<HistoryModel*>*) getCurrentWebViewHistories{
    return [self.wv__vc_paths objectForKey:[GlobalState getCurrentWebView]];
}
- (void) clearHistory:(XEngineWebView*) key{
    NSMutableArray *discardedItems = [NSMutableArray array];
    NSMutableArray* histories = [self.wv__vc_paths objectForKey:key];
    if(histories){
        for (HistoryModel *item in histories) {
            if (!item.vc)
                [discardedItems addObject:item];
        }
    }
    [histories  removeObjectsInArray:discardedItems];
}
- (void)addCurrentWebViewHistory:(HistoryModel *) history_model{
    XEngineWebView* key= [GlobalState getCurrentWebView];

    NSMutableArray* histories = [self.wv__vc_paths objectForKey:key];
    if(histories == nil ){
        histories=[NSMutableArray new];
        [self.wv__vc_paths setObject:histories forKey:key];
    }
    [histories addObject:history_model];
    [self clearHistory:key];
}


@end

