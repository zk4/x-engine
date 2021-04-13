//
//  JSIModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^XEngineCallBack)(id _Nullable result,BOOL complete);

NS_ASSUME_NONNULL_BEGIN

@interface JSIModule : NSObject
- (NSString*) moduleId;
- (int) order;
- (void) afterAllJSIModuleInited;

- (id) convert:(NSDictionary *)param  clazz:(Class)clazz;
-(NSMutableDictionary*) mergeDefault:(NSMutableDictionary*)dict defaultString:(NSString*)defaultString;
- (NSMutableDictionary*) merge:(NSMutableDictionary*) dest defaultDict:(NSMutableDictionary*) dv ;
@end

NS_ASSUME_NONNULL_END
