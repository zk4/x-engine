//
//  aJSIModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zk. All rights reserved.
//

#import "JSONModel.h"
#import "aJSIModule.h"
#import <objc/message.h>

#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]

@implementation aJSIModule

- (NSString *)moduleId {
    mustOverride();
}
- (int)order {
    return 0;
}
- (void)afterAllJSIModuleInited {
}

- (id)convert:(NSDictionary *)param clazz:(Class)clazz {
    NSError *err;
    id dto = [clazz class];

    dto = [[dto alloc] initWithDictionary:param error:&err];
    if (err) {
#ifdef DEBUG
        NSArray *errArr = err.userInfo[@"kJSONModelMissingKeys"];
        NSString *errStr = [NSString stringWithFormat:@"%@", errArr[0]];
        if (errArr.count > 1) {
            for (int i = 1; i < errArr.count; i++) {
                errStr = [errStr stringByAppendingFormat:@"、%@", errArr[i]];
            }
        }
        errStr = [errStr stringByAppendingString:@"参数"];
//TODO show error
#endif
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
                //                 [self showErrorAlert:[NSString stringWithFormat:@"%@.%@ 未实现",[self moduleId],[NSString stringWithFormat:@"%@:", name]]];
                //TODO show error

            }
        }
    } else {
        if ([self respondsToSelector:sel]) {
            action(self, sel, nil, completionHandler);
        } else {
            //                [self showErrorAlert:[NSString stringWithFormat:@"%@.%@ 未实现",[self moduleId],[NSString stringWithFormat:@"%@:", name]]];
            //TODO show error

        }
    }
}
//TODO implement this

//- (void) callJS:(NSString*)__event__ args:(id)args retCB:(void (^)(id  _Nullable ret)) retCB{
//    [[RecyleWebViewController webview] callHandler:__event__ arguments:args completionHandler:^(id  _Nullable value) {
//        retCB(value);
//    }];
//}
- (void)broadcast:(NSArray *)args {
    //    TODO implement this
    //    [self callJS:@"com.zkty.module.engine.broadcast" args:args retCB:^(id  _Nullable ret) {}];
}

@end
