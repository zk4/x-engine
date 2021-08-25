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

typedef void (^PhotoCallBack)(NSDictionary *);
typedef void (^SaveCallBack)(NSString *);
typedef void (^UploadImageCallBack)(NSDictionary *);

// cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// 保存上传数据plist的路径
#define kSaveDataCachePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"saveUploadTempData.plist"]

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
//    if (![[NSFileManager defaultManager] fileExistsAtPath:kSaveDataCachePath]) {
//        // 不存在就去创建plist
//        [_saveCacheDataArray writeToFile:kSaveDataCachePath atomically:YES];
//    } else {
//        // 存在不做任何操作
//        _saveCacheDataArray = [NSMutableArray arrayWithContentsOfFile:kSaveDataCachePath];
//    }
}

// 打开提示框
- (void)openImagePicker:(MediaParamsDTO *)dto result:(void (^)(NSDictionary *))result {
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
        NSLog(@"%@", assets);
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
        NSMutableDictionary *toPlistDict = [NSMutableDictionary dictionary];
        
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
            
            // 写入plist的值
            [toPlistDict setObject:uuid forKey:@"id"];
            [toPlistDict setObject:type forKey:@"type"];
            [toPlistDict setObject:localIdentifier forKey:@"path"];
        }];
        // 返h5
        [tempSaveArr insertObject:toH5Dict atIndex:i];
        // 往plist加数据
        [_saveCacheDataArray addObject:toPlistDict];
    }
    // 写plist
//    [_saveCacheDataArray writeToFile:kSaveDataCachePath atomically:YES];
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
        
        // 写入plist的值
        NSMutableDictionary *toPlistDict = [NSMutableDictionary dictionary];
        [toPlistDict setObject:uuid forKey:@"id"];
        [toPlistDict setObject:type forKey:@"type"];
        [toPlistDict setObject:path forKey:@"path"];
        
        // 返给h5的值
        NSString *base64Str = [self UIImageToBase64Str:[self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)]];
        NSMutableDictionary *toH5Dict = [NSMutableDictionary dictionary];
        [toH5Dict setObject:uuid forKey:@"id"];
        [toH5Dict setObject:type forKey:@"type"];
        [toH5Dict setObject:base64Str forKey:@"thumbnail"];
        
        [self.saveCacheDataArray addObject:toPlistDict];
        
//        self.saveCacheDataArray = [NSMutableArray arrayWithContentsOfFile:kSaveDataCachePath];
//        [self.saveCacheDataArray insertObject:toPlistDict atIndex:0];
//        [self.saveCacheDataArray writeToFile:kSaveDataCachePath atomically:YES];
        
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
    NSDictionary *result = @{@"data" : array};
    if(self.photoCallback) {
        self.photoCallback(result);
    }
}

#pragma ----------------------------------保存图片----------------------------------
- (void)saveImageToPhotoAlbum:(MediaSaveImageDTO *)dto result:(void (^)(NSString *))result {
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

/*************************************预览图片************************************************/
- (void)previewImg:(MediaPhotoListDTO *)dto {
    NSMutableArray *photoPathArr = [NSMutableArray new];
    [dto.imgList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [photoPathArr insertObject:[self getLocalPhotoPath:obj] atIndex:idx];
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
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"code"] = @"-1";
        dict[@"msg"] = @"url不能为空";
        result(dict);
    } else {
        requestURL = url;
        
        NSMutableArray *dataArr = [NSMutableArray new];
        
        [imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *url = [self getLocalPhotoPath:obj];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            [dataArr addObject:data];
        }];
        
        for (NSData *data in dataArr) {
            [self sendRequestWithUrl:requestURL header:header data:data name:@"test" completion:^(NSDictionary *dict) {
                result(dict);
            }];
        }
    }
}

// 上传请求
- (void)sendRequestWithUrl:(NSString *)URLString header:(NSDictionary *)header data:(NSData *)imageData name:(NSString*)name completion:(void (^)(NSDictionary *))dictBlock {
    NSString *boundary = [NSString stringWithFormat:@"iOSFormBoundary%@", [self randomString:16]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
//    request setValue:(nullable NSString *) forHTTPHeaderField:(nonnull NSString *)
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:20];
    
    // content-type
    NSString* headerString = [NSString stringWithFormat:@"multipart/form-data; boundary=----%@",boundary];
    [request setValue:headerString forHTTPHeaderField:@"Content-Type"];
    
    // body
    NSMutableData* requestMutableData = [NSMutableData data];
    NSMutableString *bodyString = [NSMutableString string];
    
    // 开始
    [bodyString appendString:[NSString stringWithFormat:@"\r\n------%@\r\n",boundary]];
    [bodyString appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.png\"\r\n",name]];
    [bodyString appendString:@"Content-Type: image/png\r\n\r\n"];
    
    // 转化为二进制数据
    [requestMutableData appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    // 二进制图
    [requestMutableData appendData:imageData];
    //结尾
    [requestMutableData appendData:[[NSString stringWithFormat:@"\r\n------%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPBody = requestMutableData;
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 20;
    NSURLSession* session  = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURLSessionDataTask *uploadtask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (dictBlock) {
                dictBlock(dict);
            }
        } else {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"code"] = @"-1";
            dict[@"msg"] = error;
            if (dictBlock) {
                dictBlock(dict);
            }
        }
    }];
    
    [uploadtask resume];
}

/*************************************utils************************************************/
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

- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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

- (NSString * )getDateFormatterString{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmssSS"];
    return [dateFormatter stringFromDate:currentDate];
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

- (NSString *)randomString:(NSInteger)number {
    NSString *ramdom;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i ; i ++) {
        int a = (arc4random() % 122);
        if (a > 96) {
            char c = (char)a;
            [array addObject:[NSString stringWithFormat:@"%c",c]];
            if (array.count == number) {
                break;
            }
        } else continue;
    }
    ramdom = [array componentsJoinedByString:@""];
    return ramdom;
}


//- (UIImage*)cutImageWidth:(NSString *)imageWidth height:(NSString *)imageHeight quality:(NSString *)imageQuality bytes:(NSString *)imageBytes{
//    return [self parseImage:self.photoImage Width:imageWidth height:imageHeight quality:imageQuality bytes:imageBytes];
//}
@end
