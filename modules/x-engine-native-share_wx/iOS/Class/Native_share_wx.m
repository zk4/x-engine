//
//  Native_share_wx.m
//  share_wx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 x-engine. All rights reserved.


#import "Native_share_wx.h"
#import "XENativeContext.h"
#import "WXApi.h"//微信分享
#import "Unity.h"
#import <XTool.h>

@interface Native_share_wx()<WXApiDelegate>
{
    
    BOOL _isLoading;
}
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
 
- (NSString * _Nullable)getIconUrl {
    return  @"";
}

- (NSString * _Nullable)getName {
    return @"native.share_wx";
}

- (NSArray<NSString *> * _Nullable)getChannels {
    return @[@"wx_friend",@"wx_zone",@"miniProgram",@"link",@"img"];
}

 

- (NSData*) shrinkSizeForKB:(float) kb imgData:(NSString*)imgData{
    NSData *binaryData;
    if (imgData.length>0) {
        if ([imgData hasPrefix:@"http:"] || [imgData hasPrefix:@"https:"]){
            UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgData]]];
            binaryData = [XToolImage compressImage:desImage toMaxDataSizeKBytes:kb miniQuality:1];


        }else{
            binaryData = [[NSData alloc] initWithBase64EncodedString:imgData options:NSDataBase64DecodingIgnoreUnknownCharacters];
            // TODO: 如果 binaryData  超过 {kb}
            // 提示用户
            
        }
    }else{
#ifdef DEBUG
        NSString* message =@"imgData 不存在";
        [XToolAlert alert:message];
#endif
        return nil;
    }
    return binaryData;
    
}
 
 
- (void)shareWithType:(NSString *)type channel:(NSString *)channel posterInfo:(NSDictionary *)info complete:(void (^)(BOOL complete)) completionHandler {
    if (self->_isLoading) {
        return;
    }
    _isLoading = YES;
    WXMediaMessage *message = [WXMediaMessage message];
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
  
    if ([channel isEqualToString:@"wx_friend"]) {
        if ([type isEqualToString:@"img"]) {
            // 高清图片
            // 图片的网络路径或base64格式图片数据
           // 大小不能超过25M
          
            WXImageObject *ext = [WXImageObject object];
            NSString *imgDatastr =[info objectForKey:@"imgData"];
            ext.imageData = [self shrinkSizeForKB:24000 imgData:imgDatastr];
            message.mediaObject = ext;
            req.message = message;
            req.scene = WXSceneSession;
        }
        if ([type isEqualToString:@"link"]) {
            WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = info[@"url"];
            message.title = info[@"title"];
            message.description = info[@"desc"];
            NSString* imgurl = info[@"imgUrl"];
            UIImage * thumbImg = [XToolImage thumbnail_64kb:imgurl];
            
            //  大小不能超过64K
            [message setThumbImage:thumbImg];
            message.mediaObject = webpageObject;
            req.message = message;
            req.scene = WXSceneSession;
        }
        if ([type isEqualToString:@"miniProgram"]) {
            WXMiniProgramObject *object = [WXMiniProgramObject object];
            
            id link = [info objectForKey:@"link"];
            if([link isKindOfClass:NSString.class] )
            {
                if ([link hasPrefix:@"http:"] || [link hasPrefix:@"https:"]){
                    object.webpageUrl = link;
                }
            }else{
                object.webpageUrl = @"1";
            }
            object.userName = info[@"userName"];
            object.path = info[@"path"];
            NSString *imgDatastr =[info objectForKey:@"imgData"];
            // 大小不能超过128k
            object.hdImageData = [self shrinkSizeForKB:127 imgData:imgDatastr];
            object.withShareTicket = YES;
            object.miniProgramType = [info[@"miniProgramType"] intValue];
            message.title = info[@"title"];
            message.description = info[@"desc"];
            NSString* imgurl = info[@"imgUrl"];
            NSData * thumbData = [XToolImage thumbnail_64kbData:imgurl];
            message.thumbData = thumbData;
            message.mediaObject = object;
            req.message = message;
            req.scene = WXSceneSession; //目前只支持会话
        }
    }
    
    if ([channel isEqualToString:@"wx_zone"]) {
        if ([type isEqualToString:@"img"]) {
            WXImageObject *ext = [WXImageObject object];
            NSString *imgDatastr =[info objectForKey:@"imgData"];
            ext.imageData = [self shrinkSizeForKB:24000 imgData:imgDatastr];
            message.mediaObject = ext;
            req.message = message;
            req.scene = WXSceneTimeline;
        }
        if ([type isEqualToString:@"link"]) {
            WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = info[@"url"];
            message.title = info[@"title"];
            message.description = info[@"desc"];
            NSString* imgurl = info[@"imgUrl"];
            UIImage * thumbImg = [XToolImage thumbnail_64kb:imgurl];
            
            //  大小不能超过64K
            [message setThumbImage:thumbImg];
            message.mediaObject = webpageObject;
            req.message = message;
            req.scene = WXSceneTimeline;
        }
    }
    
    [WXApi sendReq:req completion:^(BOOL success) {
        completionHandler(success);
        _isLoading = NO;
    }];

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

@end

