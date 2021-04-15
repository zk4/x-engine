//
//  Native_camera.m
//  camera
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

#import <AVFoundation/AVFoundation.h>
#import "Native_camera.h"
#import "NativeContext.h"
#import <ZKTY_TZImagePickerController.h>
#import <GCDWebServer.h>
#import <Photos/Photos.h>
#import "GCDWebServerDataResponse.h"
#import "GCDWebServerURLEncodedFormRequest.h"

typedef void (^PhotoCallBack)(CameraResultDTO*);
@interface Native_camera()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZKTY_TZImagePickerControllerDelegate>
@property(nonatomic,strong) GCDWebServer *webServer;
@property(nonatomic,assign) BOOL allowsEditing;
@property(nonatomic,assign) BOOL savePhotosAlbum;
@property(nonatomic,strong) UIImage * photoImage;
//@property(nonatomic,copy)   NSString * event;
@property(nonatomic,assign) BOOL isbase64;
@property(nonatomic,strong) CameraParamsDTO * cameraDto;
@property(nonatomic,copy) PhotoCallBack callback;
@end

@implementation Native_camera
NATIVE_MODULE(Native_camera)

 - (NSString*) moduleId{
    return @"com.zkty.native.camera";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    
}

- (void)openImagePicker:(CameraParamsDTO *)dto success:(void (^)(CameraResultDTO *))success {
    self.callback = success;
    self.cameraDto = dto;
    self.allowsEditing = dto.allowsEditing;
    self.savePhotosAlbum = dto.savePhotosAlbum;
    self.isbase64 = dto.isbase64;
    
    __weak typeof(self) weakself = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *pAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AVCaptureDevice requestAccessForMediaType:
         AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
         if (granted) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [weakself chooseCamera:dto];
             });
         }
         else{
             dispatch_async(dispatch_get_main_queue(), ^{
                 [weakself showPhotoOrCameraWarnAlert:@"请在iPhone的“设置-隐私”选项中允许问你的相机"];
             });
            }
        }];
    }];
    [alert addAction:pAction];
    
    UIAlertAction *xAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself choosePhotos:dto];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showPhotoOrCameraWarnAlert:@"请在iPhone的“设置-隐私”选项中允许访问你的相册"];
            });
        }
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];
    
    [alert addAction:xAction];
    [alert addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}


#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    __weak typeof(self) weakself = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        if(weakself.allowsEditing){
            weakself.photoImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            weakself.photoImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        if(weakself.savePhotosAlbum){
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImageWriteToSavedPhotosAlbum(weakself.photoImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self showPhotoOrCameraWarnAlert:@"请在iPhone的“设置-隐私”选项中允许访问你的相册"];
                    });
                }
            }];
        }
        NSMutableDictionary * ret = [NSMutableDictionary new];

        if (!self.isbase64) {
            if(self.webServer){
                [self.webServer stop];
            }
            weakself.webServer = [[GCDWebServer alloc] init];
            [self startServer];
            
            NSString* photoAppendStr = [NSString stringWithFormat:@"pic_%@.png",[weakself getDateFormatterString]];
            NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:photoAppendStr];
            if(filePath && filePath.length>0) {[UIImagePNGRepresentation(weakself.photoImage) writeToFile:filePath atomically:YES];
            }
            NSDictionary * paramDic = @{
                @"retImage":[NSString stringWithFormat:@"%@Documents/%@",@"http://127.0.0.1:18129/",photoAppendStr],
                @"contentType":@"image/png",
                @"fileName":photoAppendStr
            };
            ret[@"data"]=@[paramDic];

           [self sendParamtoWeb:ret];
        }else{
            NSDictionary * argsDic = self.cameraDto.args;
            UIImage *image = [self cutImageWidth:argsDic[@"width"] height:argsDic[@"height"] quality:argsDic[@"quality"] bytes:argsDic[@"bytes"]];
            
            NSDictionary * paramDic = @{
                @"retImage":[self UIImageToBase64Str:image],
                @"contentType":@"image/png",
                @"width": [NSNumber numberWithDouble:image.size.width],
                @"height":[NSNumber numberWithDouble:image.size.height],
                @"fileName":[NSString stringWithFormat:@"pic_%@.png",[weakself getDateFormatterString]]
            };
            ret[@"data"]=@[paramDic];
            [self sendParamtoWeb:ret];
        }
    }];
}

- (void)startServer {
    __weak typeof(self) weakself = self;
    [_webServer addHandlerForMethod:@"GET" pathRegex:@"^/.*" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
//        NSDictionary * requestData = [[NSDictionary alloc]initWithDictionary:request.query];
        
        NSDictionary * argsDic = weakself.cameraDto.args;
        UIImage *image = [weakself cutImageWidth:argsDic[@"width"] height:argsDic[@"height"] quality:argsDic[@"quality"] bytes:argsDic[@"bytes"]];
        NSData *imageData = UIImagePNGRepresentation(image);
 
        GCDWebServerDataResponse *response;
        //响应
        response = [GCDWebServerDataResponse responseWithStatusCode:200];
        //响应头设置，跨域请求需要设置，只允许设置的域名或者ip才能跨域访问本接口）
        [response setValue:@"*" forAdditionalHeader:@"Access-Control-Allow-Origin"];
        [response setValue:@"Authorization,X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method" forAdditionalHeader:@"Access-Control-Allow-Headers"];
        [response setValue:@"GET, POST, OPTIONS, PATCH, PUT, DELETE" forAdditionalHeader:@"Access-Control-Allow-Methods"];
        [response setValue:@"GET, POST, PATCH, OPTIONS, PUT, DELETE" forAdditionalHeader:@"Allow"];

        //设置options的实效性（我设置了12个小时=43200秒）
        [response setValue:@"43200" forAdditionalHeader:@"Access-Control-max-age"];
        response = [GCDWebServerDataResponse responseWithData:imageData contentType:@"image"];
        return response;
    }];
   
    [_webServer startWithPort:18129 bonjourName:@"GCD Web Server"];
}


- (void)image:(UIImage * )image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
//        [MBProgressHUD showToastWithTitle:@"保存失败" image:nil time:1.0];
        NSLog(@"保存成功");
    } else {
//        [MBProgressHUD showToastWithTitle:@"保存成功" image:nil time:1.0];
        NSLog(@"保存失败");
    }
}


#pragma 调起相机
- (void)chooseCamera:(CameraParamsDTO *)dto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.delegate = self;
        if(dto.allowsEditing){
            imagePickerController.allowsEditing = YES;
        }
        imagePickerController.sourceType = 1;
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {//ipad没有闪光灯
            imagePickerController.cameraFlashMode = dto.cameraFlashMode;
        }
        if([dto.cameraDevice isEqualToString:@"front"]) imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma 调起相册
- (void)choosePhotos:(CameraParamsDTO*)dto {
    __weak typeof(self) weakself = self;
    
    ZKTY_TZImagePickerController *imagePickerVc = [[ZKTY_TZImagePickerController alloc] initWithMaxImagesCount:dto.photoCount delegate:self];
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSMutableDictionary * ret = [NSMutableDictionary new];
        NSMutableArray * photoarrays=  [NSMutableArray new];
        NSDictionary* argsDic = dto.args;
        for(int i =0; i< photos.count; i++){
             UIImage* image=  [self parseImage:photos[i] Width:argsDic[@"width"] height:argsDic[@"height"] quality:argsDic[@"quality"] bytes:argsDic[@"bytes"]];
            [photoarrays addObject: @{
                @"retImage":[weakself UIImageToBase64Str:image],
                @"contentType":@"image/png",
                @"width": [NSNumber numberWithDouble:image.size.width],
                @"height":[NSNumber numberWithDouble:image.size.height],
                @"fileName":[NSString stringWithFormat:@"pic_%@.png",[weakself getDateFormatterString]]
            }];
        }
        ret[@"data"] = photoarrays;
        [weakself sendParamtoWeb:ret];
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];

}

- (NSMutableDictionary *)convert2DictionaryWithJSONString:(NSString *)jsonString{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"%@",err);
        return nil;
    }
    return dic;
}


- (void)sendParamtoWeb:(id)params {
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingFragmentsAllowed error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dict =  [self convert2DictionaryWithJSONString:dataString];
    CameraResultDTO *model = [CameraResultDTO new];
    model.retImage = dict[@"data"][0][@"retImage"];
    model.fileName = dict[@"data"][0][@"fileName"];
    model.contentType = dict[@"data"][0][@"contentType"];
    model.height = dict[@"data"][0][@"height"];
    model.width = dict[@"data"][0][@"width"];
    self.callback(model);
    
//    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
//    if ([topVC isKindOfClass:RecyleWebViewController.class]) {
//        RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
//
//        NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingFragmentsAllowed error:nil];
//        [webVC.webview callHandler:self.event
//                         arguments:@[[[NSString alloc] initWithData:data encoding:4]]
//                 completionHandler:^(id  _Nullable value) {}];
//    }else if([Unity sharedInstance].XXXWeb && [[Unity sharedInstance].XXXWeb isKindOfClass:[XEngineWebView class] ]){
//        XEngineWebView *web = (XEngineWebView *)[Unity sharedInstance].XXXWeb;
//        NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingFragmentsAllowed error:nil];
//        [web callHandler:self.event
//               arguments:@[[[NSString alloc] initWithData:data encoding:4]]
//       completionHandler:^(id  _Nullable value) {}];
//    }
}

- (UIImage*)parseImage:(UIImage *)image Width:(NSString *)imageWidth height:(NSString *)imageHeight quality:(NSString *)imageQuality bytes:(NSString *)imageBytes{
    NSData *imageData;
    CGFloat width_height_per = image.size.width/image.size.height;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    NSString * w = [NSString stringWithFormat:@"%@",imageWidth];
    NSString * h = [NSString stringWithFormat:@"%@",imageHeight];
    if ([self getNoEmptyString:w])  width = w.floatValue;
    if ([self getNoEmptyString:h])  height = h.floatValue;
    if (![self getNoEmptyString:w]) width = height*width_height_per;
    if (![self getNoEmptyString:h]) height = width/width_height_per;
    image= [self imageWithImageSimple:image scaledToSize:CGSizeMake(width, height)];

    NSString * quality = [NSString stringWithFormat:@"%@",imageQuality];
    NSString * bytes = [NSString stringWithFormat:@"%@",imageBytes];
    imageData = [self compressOriginalImage:image toMaxDataSizeKBytes:bytes withQuality:quality];
    return [UIImage imageWithData:imageData];
}

//图片裁剪
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


// image转base64
- (NSString *)UIImageToBase64Str:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

// 判断字符串
- (BOOL)getNoEmptyString:(NSString *)sting{
    if (sting != nil & sting != NULL & ![sting isEqualToString:@"(null)"] & ![sting isEqualToString:@"null"] &![sting isEqualToString:@""] & ![sting isKindOfClass:[NSNull class]]){
        return YES;
    }
    return NO;
}

// 压缩图片
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(NSString*)size withQuality:(NSString *)q{
    CGFloat compression ;
    if ([self getNoEmptyString:q]) {
        compression = q.floatValue;
    }else{
        compression = 1;
    }
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if ([self getNoEmptyString:size]) {
        if (data.length/1024 < size.floatValue) return data;
        CGFloat max = 1;
        CGFloat min = 0;
        for (int i = 0; i < 6; ++i) {
            compression = (max + min) / 2;
            data = UIImageJPEGRepresentation(image, compression);
            if (data.length/1024 < size.floatValue * 0.9) {
                min = compression;
            } else if (data.length/1024 > size.floatValue) {
                max = compression;
            } else {
                break;
            }
        }
        UIImage *resultImage = [UIImage imageWithData:data];
        if (data.length/1024 < size.floatValue) return data;
        
        NSUInteger lastDataLength = 0;
        while (data.length/1024 > size.floatValue && data.length/1024 != lastDataLength) {
            lastDataLength = data.length /1024;
            CGFloat ratio = (CGFloat)size.floatValue / data.length/1024;
            CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                     (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
            UIGraphicsBeginImageContext(size);
            [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            data = UIImageJPEGRepresentation(resultImage, compression);
        }
    }
    return data;
}

- (NSString * )getDateFormatterString{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmssSS"];
    return [dateFormatter stringFromDate:currentDate];
}

- (void)showPhotoOrCameraWarnAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
            //设备系统为IOS 10.0或者以上的
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}


//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }

    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UINavigationController *nav = (UINavigationController *)rootVC;
        currentVC = [self getCurrentVCFrom:[nav topViewController]];
//        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}


- (UIImage*)cutImageWidth:(NSString *)imageWidth height:(NSString *)imageHeight quality:(NSString *)imageQuality bytes:(NSString *)imageBytes{
    return [self parseImage:self.photoImage Width:imageWidth height:imageHeight quality:imageQuality bytes:imageBytes];
}
@end

