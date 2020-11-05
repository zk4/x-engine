//
//  XERouterManage.m
//  x-engine-module-router
//
//  Created by 吕冬剑 on 2020/10/14.
//

#import "XERouterManager.h"
#import <x-engine-module-engine/Unity.h>
#import <x-engine-module-engine/XEOneWebViewControllerManage.h>
#import "WXApi.h"
#import <ZKPushAnimation.h>
#import <x-engine-module-dcloud/__xengine__module_dcloud.h>
#import <XEngineContext.h>
#import <MicroAppLoader.h>

@implementation XERouterManager


+(void)routerToTarget:(NSString *)type withUri:(NSString *)uri withPath:(NSString *)path withArgs:(NSDictionary *)args withVersion:(long)version{
    if([type isEqual:@"native"]){
        NSArray *ary = [uri componentsSeparatedByString:@","];
        if(ary.count == 2){
            NSString *className = ary[0];
            UIViewController *vc = [[NSClassFromString(className) alloc] init];
            [[ZKPushAnimation instance] removeAnimationDelegate];
            [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
        }
        return;
    } else if([type isEqual:@"h5"]){
        if(![uri hasPrefix:@"http"]){
            uri = [NSString stringWithFormat:@"https://%@", uri];
        }
        [[XEOneWebViewControllerManage sharedInstance] setMainUrl:uri];
        NSMutableString *url = [[NSMutableString alloc] initWithString:uri];
        if(path.length > 0){
            if([uri hasPrefix:@"/"]){
                [url appendString:path];
            }else{
                [url appendFormat:@"/%@", path];
            }
        }
        [[XEOneWebViewControllerManage sharedInstance] pushWebViewControllerWithUrl:url];
    } else if([type isEqual:@"microapp"]){
//        int version = 1;
//        if(args[@"version"]){
//            version = [[NSString stringWithFormat:@"%@", args[@"version"]] intValue];
//        }
        if([[MicroAppLoader sharedInstance] checkMicroAppVersion:uri version:version]){
            [[XEOneWebViewControllerManage sharedInstance] pushViewControllerWithAppid:uri withPath:path withVersion:version withParams:nil];
        }else{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BTN_ACTION_NOTIFICATIONNAME"
                                                                object:@{
//                                                                    @"ROUTE_NUMBER":[NSString stringWithFormat:@"%d", version],
                                                                    @"ROUTE_TYPE":@"microapp",
                                                                    @"ROUTE_URI":[NSString stringWithFormat:@"%@", uri],
                                                                    @"ROUTE_VERSION":[NSString stringWithFormat:@"%d", version],
                                                                    @"ROUTE_PATH":[NSString stringWithFormat:@"%@", path],
            }];
        }
    } else if([type isEqual:@"uni"]){
        NSString *dcloudname = NSStringFromClass(__xengine__module_dcloud.class);
        __xengine__module_dcloud *dcloud = [[XEngineContext sharedInstance] getModuleByName:dcloudname];
        
        UniMPDTO* d = [UniMPDTO new];
        d.appId = uri;
        d.arguments = args;
        [dcloud _openUniMPWithArg:d complete:nil];
    } else if([type isEqual:@"wx"]){
        
        NSString *keyPath = [[NSBundle mainBundle] pathForResource:@"wx_appkey" ofType:@"md"];
        NSString *linkPath = [[NSBundle mainBundle] pathForResource:@"wx_ulinks" ofType:@"md"];
        if(keyPath && linkPath){
            NSString *key = [NSString stringWithContentsOfFile:keyPath encoding:NSUTF8StringEncoding error:nil];
            NSString *link = [NSString stringWithContentsOfFile:linkPath encoding:NSUTF8StringEncoding error:nil];
            if(key && link){
                [WXApi registerApp:key universalLink:link];
                
                WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
                launchMiniProgramReq.userName = uri;  //拉起的小程序的username
                launchMiniProgramReq.path = path;    ////拉起小程序页面的可带参路径，不填默认拉起小程序首页，对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"。
                launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //拉起小程序的类型
                [WXApi sendReq:launchMiniProgramReq completion:nil];
            }
        }
    }
}

@end
