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
# ifndef mustOverride
#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]
#endif
@implementation JSIModule

- (NSString *)moduleId {
    mustOverride();
}
- (int)order {
    return 0;
}
- (void)afterAllJSIModuleInited {
}

- (void)showErrorAlert:(NSString *)errorString
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:errorString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
}


- (id)convert:(NSDictionary *)param clazz:(Class)clazz {
    NSError *err;
    id dto = [clazz class];
    
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
- (NSMutableDictionary*) merge:(NSMutableDictionary*) dest defaultDict:(NSMutableDictionary*) dv {
    if(!dv) return dest;
    if(!dest) return dv;
    // 转换为 mutable 再说
    dest = [dest mutableCopy];
    dv = [dv mutableCopy];
    NSMutableDictionary* final = [@{} mutableCopy];
    // 遍历 dest 的 key
    for(NSString* destKey in [dest allKeys]){
        id value = [dest objectForKey:destKey];

        // default 里没有的相同 key
        if(![[dv allKeys] containsObject:destKey]){
            //    如果 value 是普通值或 array , 以 dest 里的值为准
            if(![value isKindOfClass:NSDictionary.class]) continue;
                
            //    如果 value 是 dictionary,以 dest 为准
            if(![value isKindOfClass:NSDictionary.class]){
                value = dest[destKey];
            }
            
            //    如果 value 是 nil?
            //    oc 不允许,滚蛋
        }
        // default 里有相同的 key
        else {
            //    如果 value 是 dict 调用 value=merge(dest[key],default[key])
            if([value isKindOfClass:NSDictionary.class])
            value = [self merge:dest[destKey] defaultDict:dv[destKey]];
            else
            value = dest[destKey];

            //    其他,使用 dest
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
-(NSMutableDictionary*) mergeDefault:(NSMutableDictionary*)dict defaultString:(NSString*)defaultString{
    if(!defaultString || defaultString.length==0) return dict;
    NSDictionary* parsed_dict= [XEngineJSBUtil jsonStringToObject:defaultString];
    return [self merge:dict defaultDict:parsed_dict];
}


@end
