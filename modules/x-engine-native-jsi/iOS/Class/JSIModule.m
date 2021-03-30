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
///TODO: implement this somewhere else

//- (void) callJS:(NSString*)__event__ args:(id)args retCB:(void (^)(id  _Nullable ret)) retCB{
//    [[RecyleWebViewController webview] callHandler:__event__ arguments:args completionHandler:^(id  _Nullable value) {
//        retCB(value);
//    }];
//}
//
//
//-(void) broadcast:(NSArray*)args{
//    [self callJS:@"com.zkty.module.engine.broadcast" args:args retCB:^(id  _Nullable ret) {}];
//}

-(BOOL) isDictionary:(id)item{
    return [item isKindOfClass:NSDictionary.class] || [item isKindOfClass:NSMutableDictionary.class];
}

-(void) assign:(NSMutableDictionary*)to from:(NSMutableDictionary*) from{
    [to addEntriesFromDictionary:from];
}

-(void) _mergeDeep:(NSMutableDictionary*) target  sources:(NSMutableArray*) sources {
    if (!target || !sources || sources.count==0) return;
    NSMutableDictionary* source = [sources lastObject];
    [sources removeLastObject];
    if ([self isDictionary:target] && [self isDictionary:source]) {
        for (NSString* key in source) {
            if ([self isDictionary:[source objectForKey:key]]) {
                if (!target[key]) [self assign:target from:[@{key:@{}} mutableCopy]];
                [self _mergeDeep:[target[key] mutableCopy]  sources:[@[source[key]] mutableCopy]];
            } else {
                [self assign: target  from:[@{key:[source objectForKey:key]} mutableCopy]];
            }
        }
    }
    
    [self _mergeDeep:target sources:sources];
}
-(void) mergeDeep:(NSMutableDictionary*) target source:(NSMutableDictionary*) source {
    if(!source || !target) return;
    [self _mergeDeep:target sources:[@[source] mutableCopy] ];
}

-(NSDictionary*) mergeDefault:(NSDictionary*)dict defaultString:(NSString*)defaultString{
    if(!defaultString || defaultString.length==0) return dict;
    
    NSDictionary* parsed_dict= [XEngineJSBUtil jsonStringToObject:defaultString];
    if(!parsed_dict) return dict;
    
    NSMutableDictionary* merged_dict=[[NSMutableDictionary alloc]initWithDictionary:parsed_dict];
    NSMutableDictionary* mutalbeUserDict=[[NSMutableDictionary alloc]initWithDictionary:dict];
    [self mergeDeep:merged_dict source:mutalbeUserDict];
    return merged_dict;
}


@end
