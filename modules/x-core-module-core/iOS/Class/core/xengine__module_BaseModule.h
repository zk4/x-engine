#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface xengine__module_BaseModule : NSObject

- (NSString*)moduleId;

- (void)onAllModulesInited;

//模块处理优先级，越小越先处理，默认为 0
- (int)order;

@end

NS_ASSUME_NONNULL_END
