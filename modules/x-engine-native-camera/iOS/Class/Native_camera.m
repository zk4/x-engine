//
//  Native_camera.m
//  camera
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "Native_camera.h"
#import "XENativeContext.h"
#import <ZKTY_TZImagePickerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "XTool.h"
typedef void (^PhotoCallBack)(NSString *);
typedef void (^SaveCallBack)(NSString *);
@interface Native_camera()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZKTY_TZImagePickerControllerDelegate>
@property(nonatomic,assign) BOOL allowsEditing;
@property(nonatomic,assign) BOOL savePhotosAlbum;
@property(nonatomic,strong) UIImage * photoImage;
@property(nonatomic,assign) BOOL isbase64;
@property(nonatomic,strong) CameraParamsDTO * cameraDto;
@property(nonatomic,copy) PhotoCallBack callback;
@property(nonatomic,copy) SaveCallBack saveCallback;
@end

@implementation Native_camera
NATIVE_MODULE(Native_camera)

- (NSString*) moduleId{
    return @"com.zkty.native.camera";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited {}

// 打开提示框
- (void)openImagePicker:(CameraParamsDTO *)dto success:(void (^)(NSString *))success {
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

//- (void)choosePhotos:(CameraParamsDTO*)dto {
//    PHFetchOptions *options = [PHFetchOptions new];
//    PHFetchResult *topLevelUserCollections = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:options];
//    PHAssetCollectionSubtype subType = PHAssetCollectionSubtypeAlbumRegular;
//    PHFetchResult *smartAlbumsResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:subType options:options];
//
//    NSMutableArray *photoGroups = [NSMutableArray array];
//    [topLevelUserCollections enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[PHAssetCollection class]]) {
//             PHAssetCollection *asset = (PHAssetCollection *)obj;
//             PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:asset options:[PHFetchOptions new]];
//             if (result.count > 0) {
//                 NSLog(@"%@", asset);
//                 NSLog(@"%@", asset.localizedTitle);
//             }
//         }
//    }];
//
//    [smartAlbumsResult enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[PHAssetCollection class]]) {
//           PHAssetCollection *asset = (PHAssetCollection *)obj;
//           PHFetchOptions *options = [[PHFetchOptions alloc] init];
//           options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
//
//           PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:asset options:options];
//           if(result.count > 0 && asset.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumVideos) {
//               NSLog(@"%@", asset);
//               NSLog(@"%@", asset.localizedTitle);
//            }
//         }
//    }];
//}

#pragma 调起相册
- (void)choosePhotos:(CameraParamsDTO*)dto {
    __weak typeof(self) weakself = self;
    ZKTY_TZImagePickerController *imagePickerVc = [[ZKTY_TZImagePickerController alloc] initWithMaxImagesCount:dto.photoCount delegate:self];
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
        for ( PHAsset *phAsset in assets) {
            PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
            option.resizeMode = PHImageRequestOptionsResizeModeExact;
            option.networkAccessAllowed = YES;
            option.synchronous = YES;//同步执行
            
            [[PHImageManager defaultManager] requestImageDataForAsset:phAsset options:option resultHandler:^(NSData *data, NSString *uti, UIImageOrientation orientation, NSDictionary *dic){
                //                                if ([uti isEqualToString:@"com.compuserve.gif"]) {
                if (data != nil) {
                    NSString *path;
                    NSURL *urlPath = [dic objectForKey:@"PHImageFileURLKey"];
                    NSString *fileName = nil;
                    if (urlPath) {
                        fileName = [[urlPath absoluteString] lastPathComponent];
                    }
                    NSLog(@"imageurl=%@",urlPath);
                }
                return;
            }];
        }
        NSLog(@"%@", photos);
        NSLog(@"%@", assets);
        for (PHAsset *as in assets) {
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.synchronous = YES;
            options.networkAccessAllowed = YES;
            options.resizeMode = PHImageRequestOptionsResizeModeFast;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
            [[PHImageManager defaultManager] requestImageForAsset:as targetSize:CGSizeMake(200, 300) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                NSLog(@"%@", result);
                NSLog(@"%@", info);
                
            }];
        }
        
        
        NSMutableDictionary * ret = [NSMutableDictionary new];
        NSMutableArray * photoarrays=  [NSMutableArray new];
        NSDictionary* argsDic = dto.args;
        float maxBytes = argsDic[@"bytes"]?[argsDic[@"bytes"] floatValue]:4000.0f;
        float q = argsDic[@"quality"]?[argsDic[@"quality"] floatValue]:1.0f;
        
        for(int i = 0; i< photos.count; i++){
            NSData* imageData= [XToolImage compressImage:photos[i] toMaxDataSizeKBytes:maxBytes miniQuality:q];
            UIImage* image = [UIImage imageWithData:imageData];
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
        NSMutableDictionary *ret = [NSMutableDictionary new];
        if (!self.isbase64) {
            
            NSString* photoAppendStr = [NSString stringWithFormat:@"pic_%@.png",[weakself getDateFormatterString]];
            NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:photoAppendStr];
            if(filePath && filePath.length>0) {[UIImagePNGRepresentation(weakself.photoImage) writeToFile:filePath atomically:YES];
            }
            NSDictionary * paramDic = @{
                @"retImage":[NSString stringWithFormat:@"%@Documents/%@",@"http://127.0.0.1:18129/",photoAppendStr],
                @"contentType":@"image/png",
                @"fileName":photoAppendStr
            };
            ret[@"data"] = @[paramDic];
            [self sendParamtoWeb:ret];
        } else {
            
            NSDictionary * argsDic = self.cameraDto.args;
            float maxBytes = argsDic[@"bytes"]?[argsDic[@"bytes"] floatValue]:4000.0f;
            float q = argsDic[@"quality"]?[argsDic[@"quality"] floatValue]:1.0f;
            
            //            UIImage *image = [self cutImageWidth:argsDic[@"width"] height:argsDic[@"height"] quality:argsDic[@"quality"] bytes:argsDic[@"bytes"]];
            NSData* imageData= [XToolImage compressImage:self.photoImage toMaxDataSizeKBytes:maxBytes miniQuality:q];
            UIImage* image = [UIImage imageWithData:imageData];
            NSDictionary * paramDic = @{
                @"retImage":[self UIImageToBase64Str:image],
                @"contentType":@"image/png",
                @"width": [NSNumber numberWithDouble:image.size.width],
                @"height":[NSNumber numberWithDouble:image.size.height],
                @"fileName":[NSString stringWithFormat:@"pic_%@.png",[weakself getDateFormatterString]]
            };
            ret[@"data"] = @[paramDic];
            [self sendParamtoWeb:ret];
        }
    }];
}

- (void)sendParamtoWeb:(id)params {
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingFragmentsAllowed error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if(self.callback) {
        self.callback(dataString);
    }
}

#pragma ----------------------------------保存图片----------------------------------
- (void)saveImageToPhotoAlbum:(SaveImageDTO *)dto saveSuccess:(void (^)(NSString *))success {
    self.saveCallback = success;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized){
            [self performSelectorInBackground:@selector(downloadImg:) withObject:dto];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showPhotoOrCameraWarnAlert:@"请在iPhone的“设置-隐私”选项中允许访问你的相册"];
            });
        }
    }];
}

- (void)downloadImg:(SaveImageDTO *)dto {
    UIImage *image = [UIImage new];
    if ([dto.type isEqualToString:@"url"]) {
        NSURL *downloadUrl = [NSURL URLWithString:dto.imageData];
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:downloadUrl]];
    } else if ([dto.type isEqualToString:@"base64"]){
        if  ([dto.imageData rangeOfString:@"base64,"].location != NSNotFound) {
            NSRange range = [dto.imageData rangeOfString:@"base64, "];
            dto.imageData = [dto.imageData substringFromIndex:range.location+range.length];
        }
        NSData *imageData =[[NSData alloc] initWithBase64EncodedString:dto.imageData options:NSDataBase64DecodingIgnoreUnknownCharacters];
        image = [UIImage imageWithData:imageData];
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}

- (void)image:(UIImage * )image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        _saveCallback(@"save error");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *enter = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [alert addAction:enter];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    } else {
        _saveCallback(@"save success");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功,请前往相册查看" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *enter = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [alert addAction:enter];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}


- (NSMutableDictionary *)convert2DictionaryWithJSONString:(NSString *)jsonString{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&err];
    if(err) {
        NSLog(@"%@",err);
        return nil;
    }
    return dic;
}

//- (UIImage*)parseImage:(UIImage *)image Width:(NSString *)imageWidth height:(NSString *)imageHeight quality:(NSString *)imageQuality bytes:(NSString *)imageBytes{
//    NSData *imageData;
//    CGFloat width_height_per = image.size.width/image.size.height;
//    CGFloat width = image.size.width;
//    CGFloat height = image.size.height;
//    NSString * w = [NSString stringWithFormat:@"%@",imageWidth];
//    NSString * h = [NSString stringWithFormat:@"%@",imageHeight];
//    if ([self getNoEmptyString:w])  width = w.floatValue;
//    if ([self getNoEmptyString:h])  height = h.floatValue;
//    if (![self getNoEmptyString:w]) width = height*width_height_per;
//    if (![self getNoEmptyString:h]) height = width/width_height_per;
//    image= [self imageWithImageSimple:image scaledToSize:CGSizeMake(width, height)];
//
//    NSString * quality = [NSString stringWithFormat:@"%@",imageQuality];
//    NSString * bytes = [NSString stringWithFormat:@"%@",imageBytes];
//    imageData = [self compressOriginalImage:image toMaxDataSizeKBytes:bytes withQuality:quality];
//    return [UIImage imageWithData:imageData];
//}

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
            CGFloat ratio = (CGFloat)size.floatValue / lastDataLength;
            CGSize finalsize = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                          (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
            UIGraphicsBeginImageContext(finalsize);
            [resultImage drawInRect:CGRectMake(0, 0, finalsize.width, finalsize.height)];
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



//
//- (UIImage*)cutImageWidth:(NSString *)imageWidth height:(NSString *)imageHeight quality:(NSString *)imageQuality bytes:(NSString *)imageBytes{
//    return [self parseImage:self.photoImage Width:imageWidth height:imageHeight quality:imageQuality bytes:imageBytes];
//}
@end

