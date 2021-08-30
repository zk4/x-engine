//
//  HistoryModel.h
//  ModuleApp
//
//  Created by zk on 2021/3/27.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UIViewController;
//@class XEngineWebView;
@interface HistoryModel : NSObject
 
//    @property (nonatomic, weak) XEngineWebView * webview;
    @property (nonatomic, copy) NSString *host;
    @property (nonatomic, copy) NSString *pathname;
    @property (nonatomic, copy) NSString *fragment;
//    @property (nonatomic, assign) BOOL onTab;

    -(NSString*) getKey;
@end

NS_ASSUME_NONNULL_END
