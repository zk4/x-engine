//
//  NSURLProtocol+WebKitSupport.m
//  NSURLProtocol+WebKitSupport
//
//  Created by yeatse on 2016/10/11.
//  Copyright © 2016年 Yeatse. All rights reserved.
//

#import "NSURLProtocol+WebKitSupport.h"
#import <WebKit/WebKit.h>

/**
 * The functions below use some undocumented APIs, which may lead to rejection by Apple.
 */

FOUNDATION_STATIC_INLINE Class ContextControllerClass() {
    static Class cls;
    if (!cls) {
        cls = [[[WKWebView new] valueForKey:@"browsingContextController"] class];
    }
    return cls;
}

FOUNDATION_STATIC_INLINE SEL RegisterSchemeSelector() {
    return NSSelectorFromString(@"registerSchemeForCustomProtocol:");
}

FOUNDATION_STATIC_INLINE SEL UnregisterSchemeSelector() {
    return NSSelectorFromString(@"unregisterSchemeForCustomProtocol:");
}

@implementation NSURLProtocol (WebKitSupport)

+ (void)wk_registerScheme:(NSString *)scheme {
    Class cls = ContextControllerClass();
    SEL sel = RegisterSchemeSelector();
    if ([(id)cls respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [(id)cls performSelector:sel withObject:scheme];
#pragma clang diagnostic pop
    }
}

+ (void)wk_unregisterScheme:(NSString *)scheme {
    Class cls = ContextControllerClass();
    SEL sel = UnregisterSchemeSelector();
    if ([(id)cls respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [(id)cls performSelector:sel withObject:scheme];
#pragma clang diagnostic pop
    }
}

static NSString* const BFHybridBTWKKey = @"blackfish";
static NSString* const BFHybridBTWKCls = @"T0M7aWh1bmRqXztoZW1jc28/Z2ZtaWhqZ2Bu";
static NSString* const BFHybridBTWKSel = @"al1gYGxyYG1PW2BeZF5Eam0/bWttZmZObWpwZ1toYzM=";
 
// 
//
//#pragma mark - public
//
//+ (void)registerScheme :(NSString *)scheme {
//    Class cls = NSClassFromString([self decodeString:BFHybridBTWKCls key:BFHybridBTWKKey]);
//    SEL sel = NSSelectorFromString([self decodeString:BFHybridBTWKSel key:BFHybridBTWKKey]);
//    if ([(id)cls respondsToSelector:sel]) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//        // 把 http 和 https 请求交给 NSURLProtocol 处理
//        [(id)cls performSelector:sel withObject:scheme];
//#pragma clang diagnostic pop
//    }
//}
//
//
//
////base64解码
//
///**
// 这个类是为了通过苹果的静态检查
// @param string 按照算法加密之后的字符串 并且base64加密
// @param key 关键字 用来计算隐藏的类
// @return 目的类名和方法名
// */
//+ (NSString *)decodeString:(NSString *)string key:(NSString *)key
//{
//    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSString *deString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//    NSMutableString *mutString = [NSMutableString new];
//    for (int i = 0;i < deString.length;i++) {
//        int strChar = [deString characterAtIndex:i];
//        int keyChar = [key characterAtIndex:(i % key.length)];
//        int charactor = strChar + (keyChar % 10);
//        [mutString appendString:[NSString stringWithFormat:@"%c",charactor]];
//    }
//
//    return mutString;
//}

@end
