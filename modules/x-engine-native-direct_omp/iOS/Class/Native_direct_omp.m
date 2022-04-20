//
//  Native_direct_omp.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 x-engine. All rights reserved.
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
#import "XTool.h"


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
        [store set:@"__native__params__" val:[XToolDataConverter dictionaryToJson:params[@"nativeParams"]]];
    }
}
 
- (nonnull NSString *)scheme {
    return @"omp";
}

- (nonnull NSString *)protocol {
    return @"http:";
}

- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params frame:(CGRect)frame {
    
    if(!protocol){
        protocol = [self protocol];
    }
    
    BOOL isHideNavBar = [params[@"hideNavbar"] boolValue];
    [self judgeParamsWithDict:params];
    NSString *queryString = [self judgeQueryWithDict:query];
    NSString *finalUrl = @"";
    
   
    NSAssert(!fragment || ![fragment hasPrefix:@"#"]  , @"fragment 不需要加#");
    fragment = (fragment && fragment.length>0) ? [NSString stringWithFormat:@"#%@",fragment] : @"";
    finalUrl = [NSString stringWithFormat:@"%@//%@%@%@%@",protocol,host,pathname,fragment,queryString];
    
    NSDictionary* nativeParams =  [params objectForKey:@"nativeParams"];
    
    BOOL isLooseNetwork = NO;
    // 判断params是否传入了 isLooseNetwork 属性
    if(nativeParams){
        isLooseNetwork = [nativeParams objectForKey:@"isLooseNetwork"];
    }

    RecyleWebViewController *vc =  [[RecyleWebViewController alloc] initWithUrl:finalUrl  withHiddenNavBar:isHideNavBar webviewFrame:frame looseNetwork:isLooseNetwork];
    vc.hidesBottomBarWhenPushed = YES;

    return  vc;
}
@end
