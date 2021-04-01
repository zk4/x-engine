//
//  iDirectManager.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 @protocol iDirectManager <NSObject>

// scheme 形如
// 1. omp   使用(protocol) http  协议，webview 带原生 api 功能
// 2. omps  使用(protocol) https 协议，webview 带原生 api 功能
// 3. http  普通(protocol) webview
// 4. https 普通(protocol) webview
// 5. microapp 使用 file 协议，打开本地微应用文件
- (void)push: (NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(nullable NSString*) fragment
        query:(nullable NSDictionary<NSString*,id>*) query
        params:(nullable NSDictionary<NSString*,id>*) params;

- (void)back: (NSString*) scheme host:(nullable NSString*) host                    fragment:(NSString*) fragment;

@end

NS_ASSUME_NONNULL_END
