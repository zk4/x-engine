//
//  Native_share_wx.m
//  share_wx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_share_wx.h"
#import "XENativeContext.h"
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
    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
        
    }];
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


// 压缩图片
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(float)size withQuality:(float)q{
    CGFloat compression ;
   
        compression = q;
    
    NSData *data = UIImageJPEGRepresentation(image, compression);
    
        if (data.length/1024 < size) return data;
        CGFloat max = 1;
        CGFloat min = 0;
        for (int i = 0; i < 6; ++i) {
            compression = (max + min) / 2;
            data = UIImageJPEGRepresentation(image, compression);
            if (data.length/1024 < size * 0.9) {
                min = compression;
            } else if (data.length/1024 > size) {
                max = compression;
            } else {
                break;
            }
        }
        UIImage *resultImage = [UIImage imageWithData:data];
        if (data.length/1024 < size) return data;
        
        NSUInteger lastDataLength = 0;
        while (data.length/1024 > size && data.length/1024 != lastDataLength) {
            lastDataLength = data.length /1024;
            CGFloat ratio = size / data.length/1024;
            CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                     (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
            UIGraphicsBeginImageContext(size);
            [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            data = UIImageJPEGRepresentation(resultImage, compression);
        }
    
    return data;
}

- (NSData*) shrinkSizeForKB:(float) kb imgData:(NSString*)imgData{
    NSData *binaryData;
    if (imgData.length>0) {
        if ([imgData hasPrefix:@"http:"] || [imgData hasPrefix:@"https:"]){
            
            UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgData]]];
            binaryData = [self compressOriginalImage:desImage toMaxDataSizeKBytes:kb withQuality:1];

        }else{
            binaryData = [[NSData alloc] initWithBase64EncodedString:imgData options:NSDataBase64DecodingIgnoreUnknownCharacters];
            // TODO: 如果 binaryData  超过 {kb}
            // 提示用户
            
        }
    }else{
#ifdef DEBUG
        @throw  [NSException exceptionWithName:@"为何没有 imgData 数据,是 url 或者 base64" reason:nil  userInfo:nil];
#endif
        return [NSData new];
    }
    return binaryData;
    
}
- (NSData *)thumbnail_64kbData:(NSString *)imgurl {
    UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
    NSData*  thumbData = [self compressOriginalImage:desImage toMaxDataSizeKBytes:63.0 withQuality:1];
    return thumbData;
  
}

- (UIImage *)thumbnail_64kb:(NSString *)imgurl {
    NSData* data = [self thumbnail_64kbData:imgurl];
    UIImage*  thumbImg = [[UIImage alloc] initWithData:data];
    return thumbImg;
}

- (void)shareWithType:(NSString *)type channel:(NSString *)channel posterInfo:(NSDictionary *)info complete:(void (^)(BOOL complete)) completionHandler {
    
    WXMediaMessage *message = [WXMediaMessage message];
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    
 
    NSString *imgDatastr =[info objectForKey:@"imgData"];
  
    if ([channel isEqualToString:@"wx_friend"]) {
        if ([type isEqualToString:@"img"]) {
            // 高清图片
            // 图片的网络路径或base64格式图片数据
           // 大小不能超过25M
          
            WXImageObject *ext = [WXImageObject object];
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
            UIImage * thumbImg = [self thumbnail_64kb:imgurl];
            
            //  大小不能超过64K
            [message setThumbImage:thumbImg];
            message.mediaObject = webpageObject;
            req.message = message;
            req.scene = WXSceneSession;
        }
        if ([type isEqualToString:@"miniProgram"]) {
            WXMiniProgramObject *object = [WXMiniProgramObject object];
            /// TODO: 应该是取link 的值
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
            // 大小不能超过128k
            object.hdImageData = [self shrinkSizeForKB:127 imgData:imgDatastr];
            object.withShareTicket = YES;
            object.miniProgramType = [info[@"miniProgramType"] intValue];
            message.title = info[@"title"];
            message.description = info[@"desc"];
            NSString* imgurl = info[@"imgUrl"];
            NSData * thumbData = [self thumbnail_64kbData:imgurl];
            message.thumbData = thumbData;
            message.mediaObject = object;
            req.message = message;
            req.scene = WXSceneSession; //目前只支持会话
        }
    }
    
    if ([channel isEqualToString:@"wx_zone"]) {
        if ([type isEqualToString:@"img"]) {
            WXImageObject *ext = [WXImageObject object];
            ext.imageData = [self shrinkSizeForKB:24000 imgData:imgDatastr];
            message.mediaObject = ext;
            req.message = message;
            req.scene = WXSceneTimeline;
        }
    }
    
    [WXApi sendReq:req completion:^(BOOL success) {
        completionHandler(success);
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

