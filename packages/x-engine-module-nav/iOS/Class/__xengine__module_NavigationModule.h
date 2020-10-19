//
//  __xengine__module_NavigationModule.h
//  AFNetworking
//
//  Created by edz on 2020/7/24.
//

#import "xengine__module_BaseModule.h"
#import "XEngineWebView.h"
#import "xengine__module_nav.h"
#import <micros.h>
NS_ASSUME_NONNULL_BEGIN

@interface __xengine__module_NavigationModule : xengine__module_nav
- (void)navigateHidden:(NSDictionary *)data complate:(XEngineCallBack)completionHandler;
- (void)navigateShow:(NSDictionary *)data callBlock:(XEngineCallBack)completionHandler;
@end

NS_ASSUME_NONNULL_END
