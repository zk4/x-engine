#import "JSIOpenModule.h"
#import "JSIContext.h"
#import "iOpenManager.h"
#import "XEngineContext.h"
@interface JSIOpenModule ()
@property (nonatomic, strong)   id<iOpenManager>  openerManger;
@end
@implementation JSIOpenModule
JSI_MODULE(JSIOpenModule)

- (NSString*) moduleId{
    return @"com.zkty.module.router";
}

-(void)afterAllJSIModuleInited {
    self.openerManger = [[XEngineContext sharedInstance] getModuleByProtocol:@protocol(iOpenManager)];
}
- (void) openTargetRouter:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {
    [self.openerManger  open:dict[@"type"] :dict[@"uri"] :dict[@"path"] :dict[@"dict"] :dict[@"version"] :dict[@"hideNavbar"]];
  }
@end
