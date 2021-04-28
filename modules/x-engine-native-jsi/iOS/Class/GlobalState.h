//
//  GlobalState.h
//  ModuleApp
//
//  Created by zk on 2021/3/27.
//  Copyright © 2021 zkty-team. All rights reserved.
//
/// TODO: 这个类不应该这样存在，污染全局
#import <Foundation/Foundation.h>
#import "HistoryModel.h"
#import "XEngineWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlobalState : NSObject
+ (instancetype)sharedInstance;

- (XEngineWebView*)getCurrentWebView;

- (HistoryModel*) getLastHistory;
- (NSMutableArray<HistoryModel *> *)getCurrentWebViewHistories;
- (NSMutableArray<HistoryModel *> *)getCurrentHostHistories;
- (void)addCurrentWebViewHistory:(HistoryModel *) history;

// 处理 tab 历史
- (void)setCurrentTabVC:(UIViewController*) vc;
- (void)addCurrentTab:(HistoryModel *) history_model;

@end
NS_ASSUME_NONNULL_END
