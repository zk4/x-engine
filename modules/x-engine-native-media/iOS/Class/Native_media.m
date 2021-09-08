//
//  Native_camera.m
//  camera
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.

#import <AVFoundation/AVFoundation.h>
#import "Native_media.h"
#import "XENativeContext.h"
#import "ZKTY_TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "XTool.h"
#import "GKPhotoBrowser.h"
#import "iGmupload.h"

typedef void (^PhotoCallBack)(NSArray *);
typedef void (^SaveCallBack)(NSMutableDictionary *);
typedef void (^UploadImageCallBack)(NSDictionary *);

// cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface Native_media()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZKTY_TZImagePickerControllerDelegate, NSURLSessionDelegate>
@property(nonatomic,assign) BOOL allowsEditing;
@property(nonatomic,assign) BOOL savePhotosAlbum;
@property(nonatomic,strong) UIImage * photoImage;
@property(nonatomic,assign) BOOL isbase64;
@property(nonatomic,strong) MediaParamsDTO * mediaDto;
@property(nonatomic,copy) PhotoCallBack photoCallback;
@property(nonatomic,copy) SaveCallBack saveCallback;
@property(nonatomic,copy) UploadImageCallBack uploadCallBack;
@property (nonatomic, strong) NSMutableArray *saveCacheDataArray;
@property (nonatomic, strong) id<iGmupload> gmUpload;

@end

@implementation Native_media
NATIVE_MODULE(Native_media)

- (NSString*) moduleId{
    return @"com.zkty.native.media";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited {
    _saveCacheDataArray = [NSMutableArray array];
    _gmUpload = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iGmupload)];
}

// 打开提示框
- (void)openImagePicker:(MediaParamsDTO *)dto result:(void (^)(NSArray *))result {
    self.photoCallback = result;
    self.mediaDto = dto;
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
            } else {
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
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself showPhotoOrCameraWarnAlert:@"请在iPhone的“设置-隐私”选项中允许访问你的相册"];
                });
            }
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:xAction];
    [alert addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma 调起相机
- (void)chooseCamera:(MediaParamsDTO *)dto {
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
- (void)choosePhotos:(MediaParamsDTO*)dto {
    ZKTY_TZImagePickerController *imagePickerVc = [[ZKTY_TZImagePickerController alloc] initWithMaxImagesCount:dto.photoCount delegate:self];
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = NO;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSArray *array = [self getImageInfoWithAssets:assets];
        [self H5CallBack:array];
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

// 拼接需要返回的数据
- (NSMutableArray *)getImageInfoWithAssets:(NSArray *)assets {
    NSMutableArray *tempSaveArr = [NSMutableArray array];
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeExact;
    // 如果图片在icloud上 下面的属性为yes可以获取 如果是no就获取不到
    option.networkAccessAllowed = YES;
    option.synchronous = YES;
    for (NSInteger i=0; i<assets.count; i++) {
        PHAsset *asset = assets[i];
        NSMutableDictionary *toH5Dict = [NSMutableDictionary dictionary];
        NSMutableDictionary *toMemoryDict = [NSMutableDictionary dictionary];
        
        NSString *uuid = [self uuidString];
        // 将图片保存到cache方便之后的获取
        NSString *path = [NSString stringWithFormat:@"%@/%@.png", kCachePath, uuid];
        
        // 原图
        [[PHImageManager defaultManager] requestImageForAsset:assets[i] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [UIImagePNGRepresentation(result) writeToFile:path atomically:YES];
        }];
        
        // 缩略图
        [[PHImageManager defaultManager] requestImageForAsset:assets[i] targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSString *type = @"image/png";
            NSString *base64Str = [self UIImageToBase64Str:result];
            NSString *localIdentifier = asset.localIdentifier;
            
            // 返给h5的值
            [toH5Dict setObject:uuid forKey:@"id"];
            [toH5Dict setObject:type forKey:@"type"];
            [toH5Dict setObject:base64Str forKey:@"thumbnail"];
            
            // 存内存的数据
            [toMemoryDict setObject:uuid forKey:@"id"];
            [toMemoryDict setObject:type forKey:@"type"];
            [toMemoryDict setObject:localIdentifier forKey:@"path"];
        }];
        // 返h5
        [tempSaveArr insertObject:toH5Dict atIndex:i];
        // 存内存
        [_saveCacheDataArray addObject:toMemoryDict];
    }
    return tempSaveArr;
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    __weak typeof(self) weakself = self;
    NSMutableArray *tempSaveArr = [NSMutableArray array];
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [UIImage new];
        NSString *type = @"image/png";
        NSString *uuid = [self uuidString];
        NSString *path = [NSString stringWithFormat:@"%@/%@.png", kCachePath, uuid];
        
        // 如果拍照后需要编辑照片从UIImagePickerControllerEditedImage获取图片
        // 如果拍照后不需要编辑照片从UIImagePickerControllerOriginalImage获取图片
        if(weakself.allowsEditing){
            image = [info objectForKey:UIImagePickerControllerEditedImage];
            // 移动图到cache文件夹中
            [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
        } else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
            // 移动图到cache文件夹中
            [UIImageJPEGRepresentation(image, 1) writeToFile:path atomically:YES];
        }
        weakself.photoImage = image;
        
        // 存入内存的值
        NSMutableDictionary *toMemoryDict = [NSMutableDictionary dictionary];
        [toMemoryDict setObject:uuid forKey:@"id"];
        [toMemoryDict setObject:type forKey:@"type"];
        [toMemoryDict setObject:path forKey:@"path"];
        
        // 返给h5的值
        NSString *base64Str = [self UIImageToBase64Str:[self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)]];
        NSMutableDictionary *toH5Dict = [NSMutableDictionary dictionary];
        [toH5Dict setObject:uuid forKey:@"id"];
        [toH5Dict setObject:type forKey:@"type"];
        [toH5Dict setObject:base64Str forKey:@"thumbnail"];
        
        // 存入内存
        [self.saveCacheDataArray addObject:toMemoryDict];
        
        // 返h5
        [tempSaveArr insertObject:toH5Dict atIndex:0];
        [self H5CallBack:tempSaveArr];
        
        // 是否需要保存相册
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
    }];
}

// 返给h5的callback
- (void)H5CallBack:(NSArray *)array {
    if(self.photoCallback) {
        self.photoCallback(array);
    }
}

// ----------------------------------保存图片---------------------------------- //
- (void)saveImageToPhotoAlbum:(MediaSaveImageDTO *)dto result:(void (^)(NSMutableDictionary *))result {
    self.saveCallback = result;
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

- (void)downloadImg:(MediaSaveImageDTO *)dto {
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (!error) {
        dict[@"status"] = @(0);
        dict[@"msg"] = @"保存成功";
        _saveCallback(dict);
    } else {
        dict[@"status"] = @(-1);
        dict[@"msg"] = @"保存失败";
        _saveCallback(dict);
    }
}

/*************************************预览图片************************************************/
- (void)previewImg:(MediaPhotoListDTO *)dto {
    NSMutableArray *photoPathArr = [NSMutableArray new];
    [dto.imgList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *uuid = [NSString stringWithFormat:@"%@", obj];
        if ([uuid hasPrefix:@"https://"] || [uuid hasPrefix:@"http://"]) {
            [photoPathArr insertObject:uuid atIndex:idx];
        } else {
            [photoPathArr insertObject:[self getLocalPhotoPath:uuid] atIndex:idx];
        }
    }];
    NSMutableArray *photos = [NSMutableArray array];
    [photoPathArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [[GKPhoto alloc] init];
        photo.url = [NSURL URLWithString:obj];
        [photos insertObject:photo atIndex:idx];
    }];
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:dto.index];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    [browser showFromVC:[self currentViewController]];
}

// 获取cache中缓存的图片地址
- (NSString *)getLocalPhotoPath:(NSString *)uuid {
    NSString *localPath = [NSString stringWithFormat:@"file://%@/%@.png", kCachePath,uuid];
    return localPath;
}

/*************************************上传图片************************************************/
- (void)uploadImageWithUrl:(NSString *)url WithHeader:(NSDictionary *)header WithImageList:(NSArray *)imageList result:(void (^)(NSDictionary * dict))result {
    NSString *requestURL = nil;
    if (url.length == 0) {
        NSMutableDictionary *backDict = [NSMutableDictionary dictionary];
        backDict[@"status"] = @(-1);
        backDict[@"msg"] = @"url不能为空";
        backDict[@"imgID"] = @"";
        backDict[@"data"] = @"";
        result(backDict);
    } else {
        requestURL = url;
        NSMutableArray *dataArr = [NSMutableArray array];
        [imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"data"] = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self getLocalPhotoPath:obj]]];
            dict[@"name"] = obj;
            [dataArr addObject:dict];
        }];
        for (NSDictionary *uploadDict in dataArr) {
            NSMutableDictionary *backDict = [NSMutableDictionary dictionary];
            [_gmUpload sendUploadRequestWithUrl:requestURL header:header imageData:uploadDict[@"data"] imageName:uploadDict[@"name"] success:^(NSDictionary *dict) {
                backDict[@"status"] = @(0);
                backDict[@"msg"] = @"接口发送成功";
                backDict[@"imgID"] = uploadDict[@"name"];
                backDict[@"data"] = [self dictionaryToJson:dict];
                result(backDict);
            } failure:^(NSDictionary *dict) {
                backDict[@"status"] = @(-1);
                backDict[@"msg"] = dict[@"msg"];
                backDict[@"imgID"] = uploadDict[@"name"];
                backDict[@"data"] = [NSMutableDictionary dictionary];
                result(backDict);
            }];
        }
    }
}

/*************************************utils************************************************/
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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

// 图片裁剪
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

- (void)showPhotoOrCameraWarnAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
            //设备系统为IOS 10.0或者以上的
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (NSString *)uuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

// 获取当前控制器
- (UIViewController*)currentViewController {
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        } else {
            break;
        }
    }
    return vc;
}
@end
