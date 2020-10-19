//
//  XERouterManage.m
//  x-engine-module-router
//
//  Created by 吕冬剑 on 2020/10/14.
//

#import "XERouterManage.h"
#import <x-engine-module-engine/Unity.h>
#import <x-engine-module-engine/XEOneWebViewControllerManage.h>
#import "WXApi.h"

@implementation XERouterManage

+(void)routerToTarget:(int)type withUri:(NSString *)uri withPath:(NSString *)path{
    switch (type) {
        case 0:{
            //http
            [[XEOneWebViewControllerManage sharedInstance] pushViewControllerWithUrl:uri withParams:nil];
            break;
        }
        case 1:{
            //appid
            [[XEOneWebViewControllerManage sharedInstance] pushViewControllerWithAppid:uri withParams:nil];
            break;
        }
        case 2:
            //uni
            break;
        case 3:{
            //wx
            [WXApi registerApp:@"" universalLink:@""];
            
            WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
            launchMiniProgramReq.userName = uri;  //拉起的小程序的username
            launchMiniProgramReq.path = path;    ////拉起小程序页面的可带参路径，不填默认拉起小程序首页，对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"。
            launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //拉起小程序的类型
            [WXApi sendReq:launchMiniProgramReq completion:nil];
            break;
        }
        case 4:{
            //navtie
            NSArray *ary = [uri componentsSeparatedByString:@","];
            for (NSString *item in ary){
                if([item hasSuffix:@"Controller"]){
                    UIViewController *vc = [[NSClassFromString(item) alloc] init];
                    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES];
                }
            }
            break;
        }
        default:
            break;
    }
}
@end
