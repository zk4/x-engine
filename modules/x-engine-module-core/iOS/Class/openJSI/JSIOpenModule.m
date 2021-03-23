#import "JSIOpenModule.h"
#import "MicroAppContext.h"
#import "iOpenManager.h"
#import "XEngineContext.h"
@interface JSIOpenModule ()
@property (nonatomic, strong)   id<iOpenManager>  openerManger;
@end
@implementation JSIOpenModule
JSI_MODULE(JSIOpenModule)

- (NSString*) JSImoduleId{
    return @"com.zkty.jsi.open";
}

-(void)afterAllJSIModuleInited {
    NSLog(@"...............");
    self.openerManger = [[XEngineContext sharedInstance] getModuleByProtocol:@protocol(iOpenManager)];
    [self.openerManger open:@"h5" :@"hello" :@"hello" :@{} :0 :FALSE];

}
@end
