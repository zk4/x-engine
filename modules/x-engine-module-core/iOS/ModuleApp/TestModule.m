#import "TestModule.h"
#import "MicroAppContext.h"

@implementation TestModule
JSI_MODULE(TestModule)
- (NSString*) JSImoduleId{
    return @"com.module.test";
}
@end
