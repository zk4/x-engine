#import "xengine__module_BaseModule.h"

@implementation xengine__module_BaseModule

- (NSString *)moduleId {
    return @"";
}

- (int) order {
    return 0;
}
- (void) onAllModulesInited{
    NSLog(@"onAllModulesInited");
}
  
@end
