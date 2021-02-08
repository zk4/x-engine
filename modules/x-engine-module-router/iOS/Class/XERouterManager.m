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
#import <x-engine-module-dcloud/__xengine__module_dcloud.h>
#import <XEngineContext.h>
#import <MicroAppLoader.h>
#import <x-engine-module-dcloud/XEUniCheckUtil.h>

@implementation XERouterManager


+(void)routerToTarget:(NSString *)type withUri:(NSString *)uri withPath:(NSString *)path withArgs:(NSDictionary *)args withVersion:(long)version{
    [XERouterManager routerToTarget:type withUri:uri withPath:path withArgs:args withVersion:version withHiddenNavbar:NO];
}

+(void)routerToTarget:(NSString *)type withUri:(NSString *)uri withPath:(NSString *)path withArgs:(NSDictionary *)args withVersion:(long)version withHiddenNavbar:(BOOL)isHidden{
    
    if(uri.length == 0){
        return;
    }
    if([type isEqual:@"native"]){
        NSArray *ary = [uri componentsSeparatedByString:@","];
        if(ary.count == 2){
            NSString *className = ary[0];
            UIViewController *vc = [[NSClassFromString(className) alloc] init];
//            [[ZKPushAnimation instance] removeAnimationDelegate];
            [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
        }
        return;
    } else if([type isEqual:@"h5"]){
        if(![[uri lowercaseString] hasPrefix:@"http"]){
            uri = [NSString stringWithFormat:@"https://%@", uri];
        }
        NSMutableString *url = [[NSMutableString alloc] initWithString:uri];
        if(path.length > 0){
            if([uri hasPrefix:@"/"]){
                [url appendString:path];
            }else{
                [url appendFormat:@"/%@", path];
            }
        }
        NSURL * URL = [NSURL URLWithString:url];
        if ([URL.host isEqualToString:@"apps.apple.com"]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
        }else{
        [[XEOneWebViewControllerManage sharedInstance] pushWebViewControllerWithHttpRouteUrl:url];
    }
} else if([type isEqual:@"microapp"]){

    if([[MicroAppLoader sharedInstance] checkMicroAppVersion:uri version:version]){
        [[XEOneWebViewControllerManage sharedInstance] pushViewControllerWithAppid:uri
                                                                          withPath:path
                                                                       withVersion:version
                                                                        withParams:nil
                                                                withIsHiddenNavbar:isHidden];
        }else{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BTN_ACTION_NOTIFICATIONNAME"
                                                                object:@{
                                                                    @"ROUTE_TYPE":@"microapp",
                                                                    @"ROUTE_URI":[NSString stringWithFormat:@"%@", uri],
                                                                    @"ROUTE_VERSION":[NSString stringWithFormat:@"%ld", version > 0 ? version : 1],
                                                                    @"ROUTE_PATH":[NSString stringWithFormat:@"%@", path],
                                                                    @"hideNavbar":@(isHidden),
            }];
        }
    } else if([type isEqual:@"uni"]){
        // fixme 超级恶心. 需要业务端做替换参数 ROUTE_ARGS
        if(!args){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BTN_ACTION_NOTIFICATIONNAME"
                                                                object:@{
                                                                    @"ROUTE_TYPE":@"uni",
                                                                    @"ROUTE_URI":[NSString stringWithFormat:@"%@", uri],
                                                                    @"ROUTE_VERSION":[NSString stringWithFormat:@"%ld", version > 0 ? version : 1],
                                                                    @"ROUTE_PATH":[NSString stringWithFormat:@"%@", path],
                                                                    @"hideNavbar":@(isHidden),
                                                                    @"ROUTE_ARGS":@{}
                                                                    
            }];
        }else {
            if([XEUniCheckUtil checkUniFile:uri]){
                NSString *dcloudname = NSStringFromClass(__xengine__module_dcloud.class);
                __xengine__module_dcloud *dcloud = [[XEngineContext sharedInstance] getModuleByName:dcloudname];
                UniMPDTO* d = [UniMPDTO new];
                d.appId = uri;
                d.redirectPath = path;
                d.arguments = args;
                [dcloud _openUniMPWithArg:d complete:nil];
            }
        }
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
    } else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BTN_ACTION_NOTIFICATIONNAME"
                                                            object:@{
                                                                @"ROUTE_TYPE":type,
                                                                @"ROUTE_URI":[NSString stringWithFormat:@"%@", uri],
                                                                @"ROUTE_VERSION":@(version),
                                                                @"ROUTE_PATH":[NSString stringWithFormat:@"%@", path],
        }];
    }
}

@end
