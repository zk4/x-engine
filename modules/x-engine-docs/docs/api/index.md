原生 api 的能力通过接口的形式对外暴露.

可参看 x-engine/modules/x-engine-native-protocols 里面的接口声明. 在功能上 iOS / android 可以尽量统一.在接口暴露上可以根据平台来.不一定要统一

举个例子, 路由管理接口:

``` objective-c
//
//  iDirectManager.h
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 x-engine. All rights reserved.
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
        params:(nullable NSDictionary<NSString*,id>*) params
        frame:(CGRect)frame;

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
        params:(nullable NSDictionary<NSString*,id>*) params
        frame:(CGRect)frame;

// 将 uri 转化为 addToTab的参数
- (void)addToTab: (UIViewController*) parent
        uri:(NSString*) uri
        params:(nullable NSDictionary<NSString*,id>*) params
        frame:(CGRect)frame;



// 将 uri 参数转化为上面 push 的参数
- (void)push: (NSString*) uri
        params:(nullable NSDictionary<NSString*,id>*) params
        frame:(CGRect)frame;

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
    params:(nullable NSDictionary<NSString*,id>*) params
    frame:(CGRect)frame;


// 增加降级映射表
// 将在打开容器失败后替换
- (void) addFallbackRouter:(NSString*) schemeHostPath fallback:(NSString*) fallback;

// 增加强制映射表
// 将在路由前直强制替换
- (void) addMappingRouter:(NSString*) schemeHostPath mappingHostPath:(NSString*) mapping;

@end
NS_ASSUME_NONNULL_END

```

接口的实现各平台自己实现.

其他的 container 在使用平台 api 时,都是通过接口获取. 引擎会自动装配.

```objective-c
id mgr = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
// 你也可以直接使用宏
id mgr = XENP(iDirectManager);
[mgr push:@"https://www.baidu.com"];
```

