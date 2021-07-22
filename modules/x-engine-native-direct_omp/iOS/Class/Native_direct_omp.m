//
//  Native_direct_omp.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "Native_direct_omp.h"
#import "XENativeContext.h"
#import "WebViewFactory.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "iDirect.h"
#import "XENativeContext.h"
#import "iStore.h"
#import <x-engine-native-direct/UINavigationController+Completion.h>
#import "UIViewController+Tag.h"


@interface Native_direct_omp()
@end
@implementation Native_direct_omp
NATIVE_MODULE(Native_direct_omp)

- (NSString *)moduleId {
    return @"com.zkty.native.direct_omp";
}

- (int)order {
    return 0;
}

- (void)afterAllNativeModuleInited{

}

/// 判断query是否有值, 有值的就拼接在url上
/// @param query 前端传入的query参数
- (NSString *)judgeQueryWithDict:(NSDictionary<NSString*,id> *)query {
    NSString *finalQueryString = nil;
    if (query) {
        NSArray *keys = query.allKeys;
        NSArray *values = query.allValues;
        NSString *forString = [NSString string];
        for (NSInteger i = 0; i<keys.count; i++) {
            forString = [forString stringByAppendingFormat:@"%@=%@&", keys[i], values[i]];
        }
        if(forString.length > 0){
            NSString *cutString = [forString substringWithRange:NSMakeRange(0, [forString length] - 1)];
            finalQueryString = [NSString stringWithFormat:@"?%@", [cutString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]]];
        }
    }
    return finalQueryString = finalQueryString ? finalQueryString : @"";
}


/// 判断params["nativeParams"]是否有值, 有值就存入store
/// @param params 前端传入的params参数
- (void)judgeParamsWithDict:(NSDictionary<NSString*,id>*)params {
    if (params[@"nativeParams"]) {
        id<iStore>store = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];
        [store set:@"__native__params__" val:[self dictionaryToJson:params[@"nativeParams"]]];
    }
}

//字典转json格式字符串:
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (nonnull NSString *)scheme {
    return @"omp";
}

- (nonnull NSString *)protocol {
    return @"http:";
}

- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
    
    if(!protocol){
        protocol = [self protocol];
    }
    
    BOOL isHideNavBar = [params[@"hideNavbar"] boolValue];
    [self judgeParamsWithDict:params];
    NSString *queryString = [self judgeQueryWithDict:query];
    NSString *finalUrl = @"";
    
   
    NSAssert(!fragment || ![fragment hasPrefix:@"#"]  , @"fragment 不需要加#");
    fragment = fragment ? [NSString stringWithFormat:@"#%@",fragment] : @"";
    finalUrl = [NSString stringWithFormat:@"%@//%@%@%@%@",protocol,host,pathname,fragment,queryString];

    XEngineWebView* webview = [[WebViewFactory sharedInstance] createWebView];

    RecyleWebViewController * vc=  [[RecyleWebViewController alloc] initWithUrl:finalUrl XEngineWebView:webview withHiddenNavBar:isHideNavBar];
    vc.hidesBottomBarWhenPushed = YES;
    

    return  vc;
}

@end
