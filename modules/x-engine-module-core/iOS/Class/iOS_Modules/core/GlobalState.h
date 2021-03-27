//
//  GlobalState.h
//  ModuleApp
//
//  Created by zk on 2021/3/27.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryModel.h"
#import "XEngineWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlobalState : NSObject
+ (instancetype)sharedInstance;

+ (NSString * _Nullable) s_microapp_root_url;
+ (void) set_s_microapp_root_url:(NSString*)val;
+ (void)setCurrentWebView:(XEngineWebView*) val;
+ (XEngineWebView*)getCurrentWebView;

- (NSMutableArray<HistoryModel *> *)getCurrentWebViewHistories;
- (void)addCurrentWebViewHistory:(HistoryModel *) history;

@end
NS_ASSUME_NONNULL_END
