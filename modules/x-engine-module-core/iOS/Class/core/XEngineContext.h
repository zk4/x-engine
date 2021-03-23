//
//  XEngineContext.h


#import <Foundation/Foundation.h>

#define NATIVE_MODULE(clz) + (void)load{ \
    [[XEngineContext sharedInstance] registerModuleByClass:clz.class];}\


@interface XEngineContext : NSObject
+ (instancetype)sharedInstance;

- (id) getModuleByProtocol:(Protocol *) proto;
- (id) getModuleById:(NSString*) moduleId;
- (NSMutableArray*) getModulesByProtocol:(Protocol *) proto;
- (void) registerModuleByClass:(Class)clazz;
- (void) start;

@end

