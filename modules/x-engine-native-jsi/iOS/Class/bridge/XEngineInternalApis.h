//
//  XEngineInternalApis.h
//  XEngineSDK

#import <Foundation/Foundation.h>
#import "XEngineWebView.h"
#import "JSIModule.h"

//TODO: 这个有点特殊，是否也应该受 JSIContext 管理？　
@interface XEngineInternalApis :  JSIModule
@property (nullable, nonatomic, weak) XEngineWebView* webview;

@end

