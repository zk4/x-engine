//
//  iDirect.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
NS_ASSUME_NONNULL_BEGIN
 @protocol iDirect <NSObject>
// scheme 形如
// 1. omp   使用(protocol) http:     协议，webview 带原生 api 功能
// 2. omps  使用(protocol) https:    协议，webview 带原生 api 功能
// 3. http  普通(protocol) http:     协议，webview 不带原生 api 功能
// 4. https 普通(protocol) https:    协议，webview 不带原生 api 功能
// 5. microapp 普通(protocol) file:  协议，打开本地微应用文件
-(NSString*) scheme;

// 注意 protocol 带:, 形如 http: https:
-(NSString*) protocol;

- (void)push:(UIViewController*) container
        params:(nullable NSDictionary<NSString*,id>*) params;  //　原生参数

- (void)back:(NSString*) host fragment:(NSString*) fragment;

// 创建容器，vc
- (UIViewController*)getContainer:(NSString*) protocol
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(nullable NSString*) fragment
        query:(nullable NSDictionary<NSString*,id>*) query
        params:(nullable NSDictionary<NSString*,id>*) params
        frame:(CGRect) frame;

@end

NS_ASSUME_NONNULL_END
