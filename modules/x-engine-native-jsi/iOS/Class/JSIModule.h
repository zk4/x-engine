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

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

- (void)showErrorAlert:(NSString *)errorString;

- (id) convert:(NSDictionary *)param  clazz:(Class)clazz;
-(NSDictionary*) mergeDefault:(NSDictionary * _Nullable )dict defaultString:(NSString*)defaultString;
- (NSDictionary*) merge:( NSDictionary* _Nullable) dest defaultDict:(NSDictionary* _Nullable) dv ;
@end

NS_ASSUME_NONNULL_END
