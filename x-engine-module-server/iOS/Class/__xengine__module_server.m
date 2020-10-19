//
//  __xengine__module_server.m
//  UIModule
//

#import "__xengine__module_server.h"
#import <XEngineContext.h>
#import <micros.h>
#import <UIViewController+.h>
#import <JSONToDictionary.h>
#import <Unity.h>
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>

@interface __xengine__module_server ()
@property(nonatomic,strong) GCDWebServer *webServer;

@end
@implementation __xengine__module_server
#pragma mark - HUD

- (instancetype)init
{
    self = [super init];
    self.webServer = [[GCDWebServer alloc] init];

    return self;
}

- (NSString *)moduleId
{
    return @"com.zkty.module.server";
}
//{
//"port":8080
//"apis":[
//     {
//        "path":"/book",
//        "method":"GET",
//        "res":{
//            "status_code":200,
//            "data":{
//
//            }
//        }
//    }
//]
//}
 - (void)startServer:(NSDictionary *)param complate:(XEngineCallBack)completionHandler {
     if([self.webServer isRunning])
     [self stopServer];
     long port =    [param[@"port"] longValue];
     NSArray * apis = param[@"apis"];
     for (NSDictionary* api  in apis){
         NSString* path = [NSString stringWithFormat:@"%@%@",@"^",api[@"path"]];
         [_webServer addHandlerForMethod:api[@"method"] pathRegex:path requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
             return [GCDWebServerDataResponse responseWithJSONObject:api[@"res"][@"data"]];
         }];
     }
     [_webServer startWithPort:port bonjourName:@"GCD Web Server"];
     completionHandler(@"a", YES);
 }
- (void)stopServer {
    [self.webServer stop];
}
- (void)showActionSheet:(NSDictionary *)param complate:(XEngineCallBack)completionHandler
{

    NSString *title = param[@"title"];
    NSString *message = param[@"content"];
    NSArray *itemList = param[@"itemList"];
    NSMutableArray *actionHandlers = [NSMutableArray array];
    for (int i = 0; i < itemList.count; i++)
    {
        ActionHandler handler = ^(UIAlertAction * _Nonnull action){
            NSLog(@"%d",i);
            completionHandler([NSString stringWithFormat:@"%d",i], YES);
        };
        [actionHandlers addObject:handler];
    }
    
    [[Unity sharedInstance].getCurrentVC showActionSheetWithTitle:title message:message cancelTitle:@"取消" sureTitles:itemList cancelHandler:^(UIAlertAction * _Nonnull action) {
        
    } sureHandlers:actionHandlers];
}
@end
