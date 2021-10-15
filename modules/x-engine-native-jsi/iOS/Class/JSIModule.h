//
//  JSIModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 x-engine. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^XEngineCallBack)(id _Nullable result,BOOL complete);

NS_ASSUME_NONNULL_BEGIN
@class XEngineWebView;

@interface JSIModule : NSObject
- (NSString*) moduleId;
- (int) order;
- (void) afterAllJSIModuleInited;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

- (void)showErrorAlert:(NSString *)errorString;

- (id) convert:(NSDictionary *)param  clazz:(Class)clazz;
-(NSDictionary*) mergeDefault:(NSDictionary * _Nullable )dict defaultString:(NSString*)defaultString;
- (NSDictionary*) merge:( NSDictionary* _Nullable) dest defaultDict:(NSDictionary* _Nullable) dv ;

// webview 实例有多个，但 JSI 模块是共享的，在回调时，必须保证当前的 webview 处理独占着处理数据
//　优化的解决办法其实是在调用 JSI 方法时，将 webview 传给直接调用的函数，但这改动起来有点大。
- (void) lockCurrentWebView:(XEngineWebView*) webview;
- (void) unlockCurrentWebView:(XEngineWebView*) webview;
- (XEngineWebView*) currentWebView;

@end

NS_ASSUME_NONNULL_END
