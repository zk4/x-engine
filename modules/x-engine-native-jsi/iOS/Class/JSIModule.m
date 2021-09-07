//
//  JSIModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSONModel.h"
#import "JSIModule.h"
#import <objc/message.h>
#import "XEngineJSBUtil.h"
#import "Unity.h"
#import "iToast.h"
#import "XENativeContext.h"
#import <os/lock.h>

# ifndef mustOverride
#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]
#endif

static  os_unfair_lock s_webviewlock = OS_UNFAIR_LOCK_INIT;
static  XEngineWebView* s_webview = nil;


@implementation JSIModule

- (NSString *)moduleId {
    mustOverride();
}
- (int)order {
    return 0;
}
- (void)afterAllJSIModuleInited {
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}

- (void)showErrorAlert:(NSString *)errorString
{
    [XENP(iToast) toast:errorString duration:1.0];
}


- (id)convert:(NSDictionary *)param clazz:(Class)clazz {
    // 目标格式是字典不做转换
    if(clazz && [NSDictionary.class isEqual:clazz])
        return param;
    NSError *err;
    id dto = [clazz class];

    if([param isKindOfClass:NSString.class]){
        return param;
    }
    if([param isKindOfClass:NSNumber.class]){
        return param;
    }
    dto = [[dto alloc] initWithDictionary:param error:&err];
    if (err) {
        
        NSArray *errArr = err.userInfo[@"kJSONModelMissingKeys"];
        NSString *errStr = [NSString stringWithFormat:@"%@", errArr[0]];
        if (errArr.count > 1) {
            for (int i = 1; i < errArr.count; i++) {
                errStr = [errStr stringByAppendingFormat:@"、%@", errArr[i]];
            }
        }
        errStr = [NSString stringWithFormat:@"检查参数(不能为空或类型不对): %@",errStr];
        [self showErrorAlert: errStr];
        
        
        return nil;
    }
    return dto;
}

- (void)callInternalMethod:(NSDictionary *)dict complete:(void (^)(id result, BOOL complete))completionHandler methodname:(NSString *)name argclass:(Class)argclass {
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@:complete:", name]);
    id (*action)(id, SEL, id, id) = (id(*)(id, SEL, id, id))objc_msgSend;
    if (argclass) {
        id dto = [self convert:dict clazz:argclass];
        if (dto) {
            if ([self respondsToSelector:sel]) {
                action(self, sel, dto, completionHandler);
            } else {
                [self showErrorAlert:[NSString stringWithFormat:@"%@.%@ 未实现",[self moduleId],[NSString stringWithFormat:@"%@:", name]]];
                
            }
        }
    } else {
        if ([self respondsToSelector:sel]) {
            action(self, sel, nil, completionHandler);
        } else {
            [self showErrorAlert:[NSString stringWithFormat:@"%@.%@ 未实现",[self moduleId],[NSString stringWithFormat:@"%@:", name]]];
            
            
        }
    }
}
- (NSDictionary*) merge:(NSDictionary*) const_dest defaultDict:(NSDictionary*) const_dv {
    if(!const_dv) return const_dest;
    if(!const_dest) return const_dv;
    // 转换为 mutable 再说
    NSMutableDictionary* dest = [const_dest mutableCopy];
    NSMutableDictionary*dv = [const_dv mutableCopy];
    NSMutableDictionary* final = [NSMutableDictionary new];
    // 遍历 dest 的 key
    for(NSString* destKey in [dest allKeys]){
        id value = [dest objectForKey:destKey];
        
        // default 里没有的相同 key
        if(![[dv allKeys] containsObject:destKey]){
            value = dest[destKey];
        }
        // default 里有相同的 key
        else {
            //  如果 value 是 dict 调用 value=merge(dest[key],default[key])
            //  现在仅处理了 dict 的 merge 情况,
            //  数组 不处理, 用不到.
            //  set 不处理, json 里没有.
            if([value isKindOfClass:NSDictionary.class]){
                value = [self merge:dest[destKey] defaultDict:dv[destKey]];
            }
            else{
                //  其他,使用 dest
                value = dest[destKey];
            }
        }
        [final setObject:value forKey:destKey];
    }
    // 处理 dest 里没有但 default 里有的 key
    // 以 default 里的值为准, 不关心类型
    for(NSString* defaultKey in [dv allKeys]){
        if(![[dest allKeys] containsObject:defaultKey]){
            [final setObject:dv[defaultKey] forKey:defaultKey];
        }
    }
    return final;
}
-(NSDictionary*) mergeDefault:(NSDictionary*)dict defaultString:(NSString*)defaultString{
    if(!defaultString || defaultString.length==0) return dict;
    NSDictionary* parsed_dict= [XEngineJSBUtil jsonStringToObject:defaultString];
    return [self merge:dict defaultDict:parsed_dict];
}


- (void) lockCurrentWebView:(XEngineWebView*) webview{
    if(webview == s_webview)return;
    while(!os_unfair_lock_trylock(&s_webviewlock)){};
    s_webview = webview;
}
- (void) unlockCurrentWebView:(XEngineWebView*) webview{
    if(s_webview==nil)return;
    s_webview =nil;
    os_unfair_lock_unlock(&s_webviewlock);
}

- (XEngineWebView*) currentWebView{
    NSAssert(s_webview, @"如果为空，你调用个啥？");
    return s_webview;
}
@end
