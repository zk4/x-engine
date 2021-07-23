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

// 特殊功能：在tab 上显示
- (void)addToTab: (UIViewController*) parent
        scheme:(NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(nullable NSString*) fragment
        query:(nullable NSDictionary<NSString*,id>*) query
        params:(nullable NSDictionary<NSString*,id>*) params;

// 将 uri 转化为 addToTab的参数
- (void)addToTab: (UIViewController*) parent
        uri:(NSString*) uri
        params:(nullable NSDictionary<NSString*,id>*) params;



// 将 uri 参数转化为上面 push 的参数
- (void)push: (NSString*) uri
        params:(nullable NSDictionary<NSString*,id>*) params;

- (void)back: (NSString*) scheme 
        host:(nullable NSString*) host                    
    fragment:(NSString*) fragment;

// 返回视图容器，vc,内部原生使用，不要暴露到JSI
- (UIViewController*) getContainer:(NSString*) scheme
    host:(nullable NSString*) host
    pathname:(NSString*) pathname
    fragment:(nullable NSString*) fragment
    query:(nullable NSDictionary<NSString*,id>*) query
    params:(nullable NSDictionary<NSString*,id>*) params;



@end



NS_ASSUME_NONNULL_END
