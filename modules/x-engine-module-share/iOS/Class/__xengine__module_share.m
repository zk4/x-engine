//
//  xengine__module_share.m
//  share
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_share.h"
#import <XEngineContext.h>
#import <micros.h>
#import "UIViewController+.h"
#import "JSONToDictionary.h"
#import <RecyleWebViewController.h>
#import <XEngineWebView.h>
#import <Unity.h>
#import "WXApi.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+Toast.h"
#import <WebKit/WebKit.h>

@interface __xengine__module_share()<WXApiDelegate>
@property (nonatomic,strong)NSString * event;
@end
//static NSString * event;
@implementation __xengine__module_share
   
- (instancetype)init{
    self = [super init];
    if (self) {
        [WXApi registerApp:@"wx2318e010458e4805" universalLink:@"https://m-center-uat-linli.timesgroup.cn"];
        
        [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString * _Nonnull log) {
            NSLog(@"////%@", log);
        }];
    
    }
    
    return self;
}

- (void)_share:(ShareReqDTO *)dto complete:(void (^)(ShareResDTO *, BOOL))completionHandler {
    self.event = dto.__event__;
    if ([self isInstall]) {
        if ([dto.type isEqualToString:@"music"] || [dto.type isEqualToString:@"video"]) {
            if (![self getNoEmptyString:dto.dataurl]) {
                [MBProgressHUD showToastWithTitle:@"请提供dataUrl" image:nil time:1.0];
                return;
            }
        }
        [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
            NSLog(@"////%@", log);
        }];
        
        WXMediaMessage *message = [WXMediaMessage message];
          [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dto.imageurl]]]];
        message.title = dto.title;
        message.description = dto.desc;
        if ([dto.type isEqualToString:@"music"]) {
            WXMusicObject * ext = [WXMusicObject object];
            ext.musicUrl = dto.dataurl;
            message.mediaObject = ext;
        }else if ([dto.type isEqualToString:@"video"]){
            WXVideoObject * ext = [WXVideoObject object];
            ext.videoUrl = dto.dataurl;
            message.mediaObject = ext;
        }else{
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = dto.link;
            message.mediaObject = ext;
        }
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        if ([dto.channel isEqualToString:@"wx_zone"]) {
            req.scene = WXSceneTimeline;;

        }else if ([dto.channel isEqualToString:@"wx_friend"]){
            req.scene = WXSceneSession;;

        }

        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];
    }else{
        [MBProgressHUD showToastWithTitle:@"没有安装微信" image:nil time:1.0];
    }
}

-(BOOL)isInstall{
    return [WXApi isWXAppInstalled];
}


#pragma mark application

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)onReq:(BaseReq *)req{
    
}
// 从微信分享过后点击返回应用的时候调用
- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
        if ([topVC isKindOfClass:RecyleWebViewController.class]) {
            RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
            ShareResDTO * d = [ShareResDTO new];
            d.code = [NSString stringWithFormat:@"%d",resp.errCode];
            d.errStr = resp.errStr?resp.errStr:@"0";
            d.type = [NSString stringWithFormat:@"%d",resp.errCode];
            if (self.event) {
                [webVC.webview callHandler:self.event arguments:d.code completionHandler:^(id  _Nullable value) {}];
            }
        }

    }
}

//判断字符串
- (BOOL)getNoEmptyString:(NSString *)sting{
    if ( [sting isKindOfClass:[NSString class]]
        && (sting.length > 0)
        && ![sting isEqualToString:@"(null)"]
        && ![sting isEqualToString:@"null"] ){
        return YES;
    }
    return NO;
}

@end
 
