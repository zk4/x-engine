//
//  XEngineContext.h


#import <Foundation/Foundation.h>

#define X_MODULE(moduleid,clz) + (void)load{ \
    [[XEngineContext sharedInstance] registerModuleId:@#moduleid clazz:clz.class];}\
- (NSString *)moduleId { return @#moduleid; }

@interface XEngineContext : NSObject
+ (instancetype)sharedInstance;

- (NSMutableArray*) modules;
- (id) getModuleByProtocol:(Protocol *) proto;
- (id) getModuleByName:(NSString*) clazzName;
- (id) getModuleById:(NSString*) moduleId;

- (NSMutableArray*) getModulesByProtocol:(Protocol *) proto;
- (void) onApplicationDelegate:(NSString*) eventName arg1:(id)application args:(id) args;
- (void) onApplicationDelegate0:(NSString*) eventName arg1:(id)application;

- (void) registerModuleId:(NSString*) moduleId clazz:(Class)clazz;
- (void) start;

@end

