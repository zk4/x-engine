//
//  __xengine__module_BaseModule.h


#import <Foundation/Foundation.h>
#import "micros.h"
NS_ASSUME_NONNULL_BEGIN

@interface xengine__module_BaseModule : NSObject  

- (NSString*)moduleId;

- (BOOL)checkRequiredParam:(id)obj name:(NSString *)name;

- (void)showErrorAlert:(NSString *)errorString;

- (void) onAllModulesInited;




/**
模块处理优先级，越小越先处理，默认为 0
 */
- (int) order;

- (id) convert:(NSDictionary *)param  clazz:(Class)clazz;

- (void) callInternalMethod:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler methodname:(NSString*) name argclass:(Class) argclass;

//- (void) callJsByFuncName:event arguments:(NSArray*)arguments  completionHandler:(void (^)(id  _Nullable value)) completionHandler;
@end

NS_ASSUME_NONNULL_END
