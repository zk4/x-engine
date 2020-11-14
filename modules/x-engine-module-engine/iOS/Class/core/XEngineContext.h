//
//  XEngineContext.h


#import <Foundation/Foundation.h>
@interface XEngineContext : NSObject
 
+ (instancetype)sharedInstance;

- (NSMutableArray*) modules;
- (id) getModuleByProtocol:(Protocol *) proto;
- (id) getModuleByName:(NSString*) clazzName;
- (NSMutableArray*) getModulesByProtocol:(Protocol *) proto;
- (void) onApplicationDelegate:(NSString*) eventName arg1:(id)application args:(id) args;
- (void) onApplicationDelegate0:(NSString*) eventName arg1:(id)application;
- (void) start;

@end

