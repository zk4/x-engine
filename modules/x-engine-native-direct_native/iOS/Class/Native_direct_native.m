//
//  Native_direct_native.m
//  direct_native
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_native.h"
#import "XENativeContext.h"

#import "Unity.h"
#import "GlobalState.h"
#import "RecyleWebViewController.h"
#import "iStore.h"

#import "MGJRouter.h"

@interface Native_direct_native()
{ }


@end
#define  JLRoutesJumpUrl(module,toController,paramaOne,paramaTwo,paramaThree,paramaFour) [NSString stringWithFormat:@"%@://%@/%@/%@/%@/%@",module,toController,paramaOne,paramaTwo,paramaThree,paramaFour];

#define  ONE_PAGE_ONE_WEBVIEW TRUE
@implementation Native_direct_native
NATIVE_MODULE(Native_direct_native)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_native";
}

- (int) order{
    return 0;
}

- (nonnull NSString *) protocol {
    return @"native:";
}

- (NSString*) scheme{
    return @"native";
}

- (void)afterAllNativeModuleInited{
    
}

- (void)back:(NSString*) host fragment:(NSString*) fragment{

    UINavigationController* navC=[Unity sharedInstance].getCurrentVC.navigationController;
    NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
    NSMutableArray<HistoryModel*>*  histories= nil;
    if(ONE_PAGE_ONE_WEBVIEW){
        histories = [[GlobalState sharedInstance] getCurrentHostHistories];
    } else {
        histories = [[GlobalState sharedInstance] getCurrentWebViewHistories];
    }
    BOOL isMinusHistory = [fragment rangeOfString:@"^-\\d+$" options:NSRegularExpressionSearch].location != NSNotFound;
    
    BOOL isNamedHistory = [fragment rangeOfString:@"^/\\w+$" options:NSRegularExpressionSearch].location != NSNotFound;
    
    if ([@"0" isEqualToString:fragment]){
        int i =0;
        for (UIViewController *vc in [ary reverseObjectEnumerator]){
            if (![vc isKindOfClass:[RecyleWebViewController class]]){
                [navC popToViewController:vc animated:YES];
                // 当 i=0 时，也就当前页就不是 RecyleWebViewController，判断现在就是在 tab 页上
                if(i>0)
                    [histories removeAllObjects];
                return;
            }
            i++;
        }
    } else if ([@"/" isEqualToString:fragment]){
        if(histories && histories.count > 0){
            [navC popToViewController:histories[0].vc animated:YES];
            [histories removeObjectsInRange:NSMakeRange(1, histories.count - 1)];
        }
    } else if ([@"-1" isEqualToString:fragment] || [@"" isEqualToString:fragment]){
        if(histories){
            if(histories.count > 1) {
                [navC popToViewController:histories[histories.count-2].vc animated:YES];
                [histories removeLastObject];
            } else if(histories.count ==1){
                [navC popViewControllerAnimated:YES];
                [histories removeLastObject];
            }
        }
    } else if(isMinusHistory) {
        if(histories){
            int minusHistory = [fragment intValue];
            if(minusHistory+histories.count<0){
                /// TODO: alert
                NSLog(@"没有历史给你退.");
            }
            [navC popToViewController:histories[histories.count-1+minusHistory].vc animated:YES];
            [histories removeObjectsInRange:NSMakeRange(histories.count+minusHistory,  -minusHistory)];
        }
    } else if (isNamedHistory){
        if(histories && histories.count > 1){
            int i = 0;
            for (HistoryModel *hm in [histories reverseObjectEnumerator]){
                if(hm && [hm.fragment isEqualToString:fragment]){
                    [navC popToViewController:hm.vc animated:YES];
                    
                    [histories removeObjectsInRange:NSMakeRange(histories.count -i,  i)];
                    return;
                }
                i++;
            }
        }
    } else {
        /// TODO: alert
        NSLog(@"what the fuck? %@",fragment);
    }
}
///提前注册原生页面网址
- (void)registerURLPattern:(NSString *)URLPattern openNativeActive:(void (^)(void))openNativeActive {
    [MGJRouter registerURLPattern:URLPattern toHandler:^(NSDictionary *routerParameters) {
        openNativeActive();
    }];
}

- (void)push:(NSString*) protocol  // 强制 protocol，非必须
        host:(NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(NSDictionary<NSString*,id>*) query
        params:(NSDictionary<NSString*,id>*) params  {
    [MGJRouter openURL:pathname withUserInfo:nil completion:^(id  _Nonnull result){}];
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

@end
 
