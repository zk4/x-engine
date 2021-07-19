//
//  UIViewController+Tag.h
//

#import <Foundation/Foundation.h>
#import "HistoryModel.h"

@interface UIViewController (ZK_Tag)
 
- (HistoryModel*) getLastHistory;
- (void)setCurrentHistory:(HistoryModel *) history;

//- (NSMutableArray<HistoryModel *> *)getCurrentHostHistories;

// 处理 tab 历史
//- (void)setCurrentTabVC:(UIViewController*) vc;
//- (void)addCurrentTab:(HistoryModel *) history_model;

@end
