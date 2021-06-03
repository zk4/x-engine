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
#import "Unity.h"

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

- (void)shareWithType:(NSString *)type channel:(NSString *)channel posterInfo:(NSDictionary *)info complete:(void (^)(NSString *__nullable channel,NSString *__nullable shareType,NSString *_Nullable imageData,BOOL complete)) completionHandler {
    
    if ([channel isEqualToString:@"wx_friend"]) {
        if ([type isEqualToString:@"img"]) {
            WXMediaMessage *message = [WXMediaMessage message];
            UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:info[@"imgUrl"]]]];
            UIImage *thumbImg = [self thumbImageWithImage:desImage limitSize:CGSizeMake(100, 100)];
            NSData *imageData = UIImageJPEGRepresentation(thumbImg, 1);//[info[@"imgData"] dataUsingEncoding:NSUTF8StringEncoding];
            WXImageObject *ext = [WXImageObject object];
            ext.imageData = imageData;
            
            message.mediaObject = ext;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            
            [WXApi sendReq:req
                completion:^(BOOL success) {
                completionHandler(channel, type,
                                  [[NSString alloc]
                                   initWithData:imageData
                                   encoding:NSUTF8StringEncoding],
                                  YES);
            }];
        }
        if ([type isEqualToString:@"link"]) {
            WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = info[@"link"];
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = info[@"title"];
            message.description = info[@"desc"];
//            [message setThumbImage:[UIImage imageNamed:@"mayun.jpg"]];
            message.mediaObject = webpageObject;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req completion:^(BOOL success) { }];
        }
        if ([type isEqualToString:@"miniProgram"]) {

            WXMiniProgramObject *object = [WXMiniProgramObject object];
            object.webpageUrl = info[@"link"];
            object.userName = info[@"userName"];
            object.path = info[@"path"];
            UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:info[@"imgUrl"]]]];
            UIImage *thumbImg = [self thumbImageWithImage:desImage limitSize:CGSizeMake(100, 100)];
            object.hdImageData = UIImageJPEGRepresentation(thumbImg, 1);
            object.withShareTicket = YES;
            object.miniProgramType = [info[@"miniProgramType"] intValue];
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = info[@"title"];
            message.description = info[@"desc"];
            message.thumbData = nil;
            message.mediaObject = object;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;

            req.scene = WXSceneSession; //目前只支持会话
            [WXApi sendReq:req completion:^(BOOL success) { }];
        }
    }
    if ([channel isEqualToString:@"wx_zone"]) {
        if ([type isEqualToString:@"img"]) {
            WXMediaMessage *message = [WXMediaMessage message];
            WXImageObject *ext = [WXImageObject object];
            UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:info[@"imgUrl"]]]];
            UIImage *thumbImg = [self thumbImageWithImage:desImage limitSize:CGSizeMake(100, 100)];
            ext.imageData = UIImageJPEGRepresentation(thumbImg, 1);;

            message.mediaObject = ext;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneTimeline;
            
            [WXApi sendReq:req completion:^(BOOL success) {
                completionHandler(channel, type, [[NSString alloc] initWithData:UIImageJPEGRepresentation(thumbImg, 1) encoding:NSUTF8StringEncoding], success);
            }];
        }
    }
}

- (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize {
    
    if (scImg.size.width <= limitSize.width && scImg.size.height <= limitSize.height) {
        return scImg;
    }
    CGSize thumbSize;
    if (scImg.size.width / scImg.size.height > limitSize.width / limitSize.height) {
        thumbSize.width = limitSize.width;
        thumbSize.height = limitSize.width / scImg.size.width * scImg.size.height;
    } else {
        thumbSize.height = limitSize.height;
        thumbSize.width = limitSize.height / scImg.size.height * scImg.size.width;
    }
    UIGraphicsBeginImageContext(thumbSize);
    [scImg drawInRect:(CGRect){CGPointZero,thumbSize}];
    UIImage *thumbImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImg;

}



- (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}
//- (void)shareChannel:(nonnull NSString *)channel type:(NSString *)type shareData:(nonnull OpenShareUiDTO *)dto complete:(nonnull void (^)(BOOL))completionHandler {
//    NSLog(@"---");
//    if ([channel isEqualToString:@"wx_friend"]) {
//        if ([type isEqualToString:@"text"]) {
//            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//            req.bText = YES;
//            req.text = dto.contentInfo.text;
//            req.scene = WXSceneSession;
//            [WXApi sendReq:req completion:^(BOOL success) {
//                NSLog(success?@"分享成功":@"分享失败");
//                completionHandler(success);
//            }];
//        }
//        if ([type isEqualToString:@"img"]) {
//            WXMediaMessage *message = [WXMediaMessage message];
//            UIImage *imagee = [UIImage imageNamed:@"mayun.jpg"];
//            NSData *imageData = UIImageJPEGRepresentation(imagee, 0.7);
//
//            WXImageObject *ext = [WXImageObject object];
//            ext.imageData = imageData;
//
//            message.mediaObject = ext;
//
//            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//            req.bText = NO;
//            req.message = message;
//            req.scene = WXSceneSpecifiedSession;
//
//            [WXApi sendReq:req completion:^(BOOL success) {
//                completionHandler(success);
//            }];
//        }
//        if ([type isEqualToString:@"link"]) {
//
//            WXWebpageObject *webpageObject = [WXWebpageObject object];
//            webpageObject.webpageUrl = dto.contentInfo.link;
//            WXMediaMessage *message = [WXMediaMessage message];
//            message.title = dto.contentInfo.title;
//            message.description =dto.contentInfo.desc;
//            [message setThumbImage:[UIImage imageNamed:@"mayun.jpg"]];
//            message.mediaObject = webpageObject;
//            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//            req.bText = NO;
//            req.message = message;
//            req.scene = WXSceneSession;
//            [WXApi sendReq:req completion:^(BOOL success) {
//                completionHandler(success);
//            }];
//        }
//        if ([type isEqualToString:@"miniProgram"]) {
//            WXMiniProgramObject *object = [WXMiniProgramObject object];
//            object.webpageUrl =  dto.contentInfo.url;
//            object.userName = dto.contentInfo.userName;
//            object.path = dto.contentInfo.path;
//            object.hdImageData = dto.contentInfo.imgData;
//            object.withShareTicket = YES;
//            object.miniProgramType = 0;//正式，开发，体验
//            WXMediaMessage *message = [WXMediaMessage message];
//            message.title = dto.contentInfo.title;
//            message.description = dto.contentInfo.desc;
//            message.thumbData = dto.contentInfo.imgData;  //兼容旧版本节点的图片，小于32KB，新版本优先
//                                      //使用WXMiniProgramObject的hdImageData属性
//            message.mediaObject = object;
//            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//            req.bText = NO;
//            req.message = message;
//            req.scene = WXSceneSession;  //目前只支持会话
//            [WXApi sendReq:req completion:^(BOOL success) {
//                completionHandler(success);
//            }];
//        }
//    }
//    ///支持分享小程序类型消息至会话，暂不支持分享至朋友圈。
//    if ([channel isEqualToString:@"wx_zone"]) {
//        if ([type isEqualToString:@"text"]) {
//            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//            req.bText = YES;
//            req.text = dto.contentInfo.text;
//            req.scene = WXSceneSession;
//            [WXApi sendReq:req completion:^(BOOL success) {
//                NSLog(success?@"分享成功":@"分享失败");
//                completionHandler(success);
//            }];
//        }
//        if ([type isEqualToString:@"img"]) {
//            WXMediaMessage *message = [WXMediaMessage message];
//            UIImage *imagee = [UIImage imageNamed:@"mayun.jpg"];
//            NSData *imageData = UIImageJPEGRepresentation(imagee, 0.7);
//
//            WXImageObject *ext = [WXImageObject object];
//            ext.imageData = imageData;
//
//            message.mediaObject = ext;
//
//            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//            req.bText = NO;
//            req.message = message;
//            req.scene = WXSceneSpecifiedSession;
//
//            [WXApi sendReq:req completion:^(BOOL success) {
//                completionHandler(success);
//            }];
//        }
//        if ([type isEqualToString:@"link"]) {
//
//            WXWebpageObject *webpageObject = [WXWebpageObject object];
//            webpageObject.webpageUrl = dto.contentInfo.link;
//            WXMediaMessage *message = [WXMediaMessage message];
//            message.title = dto.contentInfo.title;
//            message.description =dto.contentInfo.desc;
//            [message setThumbImage:[UIImage imageNamed:@"mayun.jpg"]];
//            message.mediaObject = webpageObject;
//            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//            req.bText = NO;
//            req.message = message;
//            req.scene = WXSceneSession;
//            [WXApi sendReq:req completion:^(BOOL success) {
//                completionHandler(success);
//            }];
//        }
//    }
//}

@end

