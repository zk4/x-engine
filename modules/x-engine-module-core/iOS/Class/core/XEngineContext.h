//
//  XEngineContext.h


#import <Foundation/Foundation.h>

#define X_MODULE(clz) + (void)load{ \
    [[XEngineContext sharedInstance] registerModuleByClass:clz.class];}\


@interface XEngineContext : NSObject
+ (instancetype)sharedInstance;

- (NSMutableArray*) modules;
- (id) getModuleByProtocol:(Protocol *) proto;
- (id) getModuleByName:(NSString*) clazzName;
- (id) getModuleById:(NSString*) moduleId;
- (NSMutableArray*) getModulesByProtocol:(Protocol *) proto;
- (void) registerModuleByClass:(Class)clazz;
- (void) start;

@end

