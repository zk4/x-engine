//
//  Native_share_wx.m
//  share_wx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_share_wx.h"
#import "XENativeContext.h"
#import "Native_share.h"
#import "WXApi.h"//微信分享

@interface Native_share_wx()<WXApiDelegate>
{ }
@end

@implementation Native_share_wx
NATIVE_MODULE(Native_share_wx)

 - (NSString*) moduleId{
    return @"com.zkty.native.share_wx";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
-(NSString*) test{
    return @"test";
}

- (NSString * _Nullable)getIconUrl {
    return  @"";
}

- (NSString * _Nullable)getName {
    return @"native.share_wx";
}

- (NSArray<NSString *> * _Nullable)getTypes {
    return @[@"wx_friend",@"wx_zone"];
}
- (void)shareChannel:(nonnull NSString *)channel type:(NSString *)type shareData:(nonnull ShareInfoModel *)dto complete:(nonnull void (^)(BOOL))completionHandler {
    
    if ([channel isEqualToString:@"wx_friend"]) {
        if ([type isEqualToString:@"text"]) {
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = YES;
            req.text = dto.contentInfo.text;
            req.scene = WXSceneSession;
            [WXApi sendReq:req completion:^(BOOL success) {
                NSLog(success?@"分享成功":@"分享失败");
                completionHandler(success);
            }];
        }
        if ([type isEqualToString:@"img"]) {
            WXMediaMessage *message = [WXMediaMessage message];
            UIImage *imagee = [UIImage imageNamed:@"mayun.jpg"];
            NSData *imageData = UIImageJPEGRepresentation(imagee, 0.7);
            
            WXImageObject *ext = [WXImageObject object];
            ext.imageData = imageData;
            
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSpecifiedSession;
            
            [WXApi sendReq:req completion:^(BOOL success) {
                completionHandler(success);
            }];
        }
        if ([type isEqualToString:@"link"]) {
            
            WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = dto.contentInfo.link;
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = dto.contentInfo.title;
            message.description =dto.contentInfo.desc;
            [message setThumbImage:[UIImage imageNamed:@"mayun.jpg"]];
            message.mediaObject = webpageObject;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req completion:^(BOOL success) {
                completionHandler(success);
            }];
        }
        if ([type isEqualToString:@"miniProgram"]) {
            WXMiniProgramObject *object = [WXMiniProgramObject object];
            object.webpageUrl =  dto.contentInfo.url;
            object.userName = dto.contentInfo.userName;
            object.path = dto.contentInfo.path;
            object.hdImageData = dto.contentInfo.imgData;
            object.withShareTicket = YES;
            object.miniProgramType = 0;//正式，开发，体验
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = dto.contentInfo.title;
            message.description = dto.contentInfo.desc;
            message.thumbData = dto.contentInfo.imgData;  //兼容旧版本节点的图片，小于32KB，新版本优先
                                      //使用WXMiniProgramObject的hdImageData属性
            message.mediaObject = object;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;  //目前只支持会话
            [WXApi sendReq:req completion:^(BOOL success) {
                completionHandler(success);
            }];
        }
    }
    ///支持分享小程序类型消息至会话，暂不支持分享至朋友圈。
    if ([channel isEqualToString:@"wx_zone"]) {
        if ([type isEqualToString:@"text"]) {
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = YES;
            req.text = dto.contentInfo.text;
            req.scene = WXSceneSession;
            [WXApi sendReq:req completion:^(BOOL success) {
                NSLog(success?@"分享成功":@"分享失败");
                completionHandler(success);
            }];
        }
        if ([type isEqualToString:@"img"]) {
            WXMediaMessage *message = [WXMediaMessage message];
            UIImage *imagee = [UIImage imageNamed:@"mayun.jpg"];
            NSData *imageData = UIImageJPEGRepresentation(imagee, 0.7);
            
            WXImageObject *ext = [WXImageObject object];
            ext.imageData = imageData;
            
            message.mediaObject = ext;
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSpecifiedSession;
            
            [WXApi sendReq:req completion:^(BOOL success) {
                completionHandler(success);
            }];
        }
        if ([type isEqualToString:@"link"]) {
            
            WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = dto.contentInfo.link;
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = dto.contentInfo.title;
            message.description =dto.contentInfo.desc;
            [message setThumbImage:[UIImage imageNamed:@"mayun.jpg"]];
            message.mediaObject = webpageObject;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req completion:^(BOOL success) {
                completionHandler(success);
            }];
        }
    }
    
    
    
    
    
    
//    WXMediaMessage *message = [WXMediaMessage message];
//    
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
//    
//    WXImageObject *ext = [WXImageObject object];
//    ext.imageData = imageData;
//    
//    message.mediaObject = ext;
//    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    req.scene = WXSceneSession;
//
//    [WXApi sendReq:req completion:^(BOOL success) {
//        completionHandler(success);
//    }];
}
- (void)shareTypeWithType:(nonnull NSString *)type shareData:(nonnull ShareInfoModel *)dto complete:(nonnull void (^)(BOOL))completionHandler {
    
    
}

@end
 
