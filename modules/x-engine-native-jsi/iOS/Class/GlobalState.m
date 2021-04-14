//
//  GlobalState.m
//  ModuleApp
//
//  Created by zk on 2021/3/27.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "GlobalState.h"
#import "HistoryModel.h"
#import "WebViewFactory.h"
@interface GlobalState()
@property(nonatomic,strong) NSMutableArray<HistoryModel*>* histories;
@property(nonatomic,weak)   UIViewController* current_tab_vc;
@property(nonatomic,strong) NSMutableArray<HistoryModel*>* tab_vcs;
@end

@implementation GlobalState

- (instancetype)init {
    self = [super init];
    self.histories = [[NSMutableArray alloc]  init];
    self.tab_vcs = [[NSMutableArray alloc]  init];
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

- (void)setCurrentTabVC:(UIViewController*) vc{
    _current_tab_vc = vc;
}

- (NSString*) getLastHost{
    NSString* host = [_histories lastObject].host;
    /// 那就是在 tab 上了.
    if(!host){
        host =[[GlobalState sharedInstance] getCurrentTab].host;
    }
    return host;
}

- (XEngineWebView*)getCurrentWebView{
    NSPointerArray* webviews =  [WebViewFactory sharedInstance].webviews;
    [webviews addPointer:NULL];
    [webviews compact];
    return [[webviews allObjects] lastObject];
}
- (NSMutableArray<HistoryModel*>*) getCurrentWebViewHistories{
    [self clearHistory];
    
    XEngineWebView* lastwebview =  [_histories lastObject].webview;
    NSMutableArray* ret = [NSMutableArray new];
    if(lastwebview){
        for(HistoryModel* hm in  [_histories reverseObjectEnumerator]){
            if(lastwebview == hm.webview)
                [ret insertObject:hm atIndex:0];
        }
    }
    return ret;
}
- (NSMutableArray<HistoryModel *> *)getCurrentHostHistories{
    [self clearHistory];
    
    NSString* host =  [_histories lastObject].host;
    NSMutableArray* ret = [NSMutableArray new];
    if(host){
        for(HistoryModel* hm in  [_histories reverseObjectEnumerator]){
            if(host == hm.host)
                [ret insertObject:hm atIndex:0];
        }
    }
    return ret;
    
}
- (void) clearHistory{
    NSMutableArray *discardedItems = [NSMutableArray array];
    for (HistoryModel *item in _histories) {
        if (!item.vc)
            [discardedItems addObject:item];
    }
    [_histories  removeObjectsInArray:discardedItems];
}

- (void)addCurrentWebViewHistory:(HistoryModel *) history_model{
    [self clearHistory];
    [_histories addObject:history_model];
}
- (HistoryModel*)getCurrentTab{
    for (HistoryModel *item in _tab_vcs) {
        if (item.vc== _current_tab_vc)
            return item;
    }
    @throw [NSException exceptionWithName:@"what the fuck" reason:@"不允许出现这种情况" userInfo:nil];
}
- (void)addCurrentTab:(HistoryModel *) history_model{
    [_tab_vcs addObject:history_model];
}

@end

