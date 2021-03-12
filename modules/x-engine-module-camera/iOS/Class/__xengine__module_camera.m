//
//  xengine__module_camera.m
//  camera
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_camera.h"
#import <XEngineContext.h>
#import <x-engine-module-engine/micros.h>
//#import <x-engine-module-tools/UIViewController+.h>
#import <x-engine-module-tools/JSONToDictionary.h>
#import <Unity.h>
#import <x-engine-module-engine/XEngineWebView.h>
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>
#import <GCDWebServerURLEncodedFormRequest.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <RecyleWebViewController.h>
#import "ZKTY_TZImagePickerController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+Toast.h"

typedef void(^CameraResult)(CameraRetDTO *, BOOL);
@interface __xengine__module_camera()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZKTY_TZImagePickerControllerDelegate>
@property(nonatomic,strong) GCDWebServer *webServer;
@property(nonatomic,assign) BOOL allowsEditing;
@property(nonatomic,assign) BOOL savePhotosAlbum;
@property(nonatomic,strong) UIImage * photoImage;
@property(nonatomic,copy)   NSString * event;
@property(nonatomic,assign) BOOL isbase64;
@property(nonatomic,strong) CameraDTO * cameraDto;

@end

@implementation __xengine__module_camera

- (void)_openImagePicker:(CameraDTO *)dto complete:(CameraResult)completionHandler {
    self.cameraDto = dto;
    self.allowsEditing = dto.allowsEditing;
    self.savePhotosAlbum = dto.savePhotosAlbum;
    self.isbase64 = dto.isbase64;
    self.event = dto.__event__;
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
    [alert addAction:xAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];
//    [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alert addAction:cancelAction];
    
    [[Unity sharedInstance].getCurrentVC presentViewController:alert animated:YES completion:nil];
}


-(void)chooseCamera:(CameraDTO*)dto{
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
        
        UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
        [topVC.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

-(void)choosePhotos:(CameraDTO*)dto{
    __weak typeof(self) weakself = self;
    ZKTY_TZImagePickerController *imagePickerVc = [[ZKTY_TZImagePickerController alloc] initWithMaxImagesCount:dto.photoCount delegate:self];
//    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowTakeVideo = NO;
//    imagePickerVc.allowTakePicture = NO;
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
        ret[@"data"]=photoarrays;
        [weakself sendParamtoWeb:ret];
        
    }
     ];
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;

    [topVC.navigationController presentViewController:imagePickerVc animated:YES completion:nil];


}

-(void)image:(UIImage * )image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [MBProgressHUD showToastWithTitle:@"保存失败" image:nil time:1.0];
    }else{
        [MBProgressHUD showToastWithTitle:@"保存成功" image:nil time:1.0];

    }
}

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
        UIImage *image = [self cutImageWidth:argsDic[@"width"] height:argsDic[@"height"] quality:argsDic[@"quality"] bytes:argsDic[@"bytes"]];
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

-(void)showPhotoOrCameraWarnAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
            //设备系统为IOS 10.0或者以上的
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }]];
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    [topVC.navigationController presentViewController:alert animated:true completion:nil];
}

//图片裁剪
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//压缩图片
-(NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(NSString*)size withQuality:(NSString *)q{
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

//判断字符串
-(BOOL)getNoEmptyString:(NSString *)sting{
    if (sting != nil & sting != NULL & ![sting isEqualToString:@"(null)"] & ![sting isEqualToString:@"null"] &![sting isEqualToString:@""] & ![sting isKindOfClass:[NSNull class]]){
        return YES;
    }
    return NO;
}

-(NSString * )getDateFormatterString{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmssSS"];
    return [dateFormatter stringFromDate:currentDate];
}

//image转base64
- (NSString *)UIImageToBase64Str:(UIImage *)image{
    
    NSData *data = UIImagePNGRepresentation(image);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

-(UIImage*)cutImageWidth:(NSString *)imageWidth height:(NSString *)imageHeight quality:(NSString *)imageQuality bytes:(NSString *)imageBytes{
    return [self parseImage:self.photoImage Width:imageWidth height:imageHeight quality:imageQuality bytes:imageBytes];
}

-(UIImage*)parseImage:(UIImage *)image Width:(NSString *)imageWidth height:(NSString *)imageHeight quality:(NSString *)imageQuality bytes:(NSString *)imageBytes{
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
    image= [__xengine__module_camera imageWithImageSimple:image scaledToSize:CGSizeMake(width, height)];

    NSString * quality = [NSString stringWithFormat:@"%@",imageQuality];
    NSString * bytes = [NSString stringWithFormat:@"%@",imageBytes];
    imageData = [self compressOriginalImage:image toMaxDataSizeKBytes:bytes withQuality:quality];
    return [UIImage imageWithData:imageData];
}


-(void)sendParamtoWeb:(id)param{
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    if ([topVC isKindOfClass:RecyleWebViewController.class]) {
        RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
 
        NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingFragmentsAllowed error:nil];
        [webVC.webview callHandler:self.event
                         arguments:@[[[NSString alloc] initWithData:data encoding:4]]
                 completionHandler:^(id  _Nullable value) {}];
    }else if([Unity sharedInstance].XXXWeb && [[Unity sharedInstance].XXXWeb isKindOfClass:[XEngineWebView class] ]){
        XEngineWebView *web = (XEngineWebView *)[Unity sharedInstance].XXXWeb;
        NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingFragmentsAllowed error:nil];
        [web callHandler:self.event
               arguments:@[[[NSString alloc] initWithData:data encoding:4]]
       completionHandler:^(id  _Nullable value) {}];
    }
}

//保存图片
- (void)_saveImageToAlbum:(SaveImageDTO *)dto complete:(void (^)(BOOL))completionHandler {
    
    UIImage * image = [UIImage new];
    if ([dto.type isEqualToString:@"url"]) {
        image = [UIImage imageWithData:[NSData
        dataWithContentsOfURL:[NSURL URLWithString:dto.imageData]]];
    }else if([dto.type isEqualToString:@"base64"]){
        if  ([dto.imageData rangeOfString:@"base64,"].location !=NSNotFound) {
            NSRange range = [dto.imageData rangeOfString:@"base64, "];
            dto.imageData = [dto.imageData substringFromIndex:range.location+range.length];
        }
        NSData * imageData =[[NSData alloc] initWithBase64EncodedString:dto.imageData options:NSDataBase64DecodingIgnoreUnknownCharacters];
        image = [UIImage imageWithData:imageData ];
    }
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized){
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showPhotoOrCameraWarnAlert:@"请在iPhone的“设置-隐私”选项中允许访问你的相册"];
            });
        }
    }];
}

@end
 


