//
//  Native_media2.m
//  media2
//


#import "Native_media2.h"
#import <AVFoundation/AVFoundation.h>
#import "XENativeContext.h"
#import "ZKTY_TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "XTool.h"
#import "GKPhotoBrowser.h"
#import <iMediaDelegate.h>

// cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

typedef void (^PhotoCallBack)(NSArray *images, NSArray *assets);
typedef void (^SaveCallBack)(NSMutableDictionary *);
typedef void (^UploadImageCallBack)(NSDictionary *);

@interface Native_media2() <UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZKTY_TZImagePickerControllerDelegate>
@property (nonatomic, strong) id<iMedia2Delegate> mediaDelegate;
@property(nonatomic,copy) PhotoCallBack photoCallback;
@property(nonatomic,copy) SaveCallBack saveCallback;
@property(nonatomic,copy) UploadImageCallBack uploadCallBack;

@property(nonatomic,assign) BOOL allowsEditing;
@property(nonatomic,assign) BOOL savePhotosAlbum;
@property(nonatomic,strong) UIImage * photoImage;
@property(nonatomic,assign) BOOL isbase64;
@property(nonatomic,strong) Media2ParamsDTO * mediaDto;
@end

@implementation Native_media2
NATIVE_MODULE(Native_media2)

- (NSString*)moduleId {
    return @"com.zkty.native.media2";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited {
    self.mediaDelegate= XENP(iMedia2Delegate);
} 
 

/// 打开picker
/// @param dto dto
/// @param result callback
- (void)openImagePicker:(Media2ParamsDTO *)dto result:(void (^)(NSArray<UIImage *> *, NSArray *))result {
    self.photoCallback = result;
    self.mediaDto = dto;
    self.allowsEditing = dto.allowsEditing;
    self.savePhotosAlbum = dto.savePhotosAlbum;
    self.isbase64 = dto.isbase64;
    
    __weak typeof(self) weakself = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
    
    [alert addAction:cameraAction];
    [alert addAction:photoAction];
    [alert addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma 调起相机
- (void)chooseCamera:(Media2ParamsDTO *)dto {
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

/// 调起相册/以及相册的回调
/// @param dto dto
- (void)choosePhotos:(Media2ParamsDTO*)dto {
    ZKTY_TZImagePickerController *imagePickerVc = [[ZKTY_TZImagePickerController alloc] initWithMaxImagesCount:dto.photoCount delegate:self];
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if(self.photoCallback) {
            self.photoCallback(photos, assets);
        }
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

/// UIImagePickerControllerDelegate/相机的回调
/// @param picker picker
/// @param info info
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        __weak typeof(self) weakself = self;
        UIImage *image = [UIImage new];
        if(self.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        // 是否需要保存相册
        if(self.savePhotosAlbum) {
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
        
        NSArray *array = [NSArray arrayWithObject:image];
        if(self.photoCallback) {
            self.photoCallback(array, nil);
        }
    }];
}

/// 预览图片
/// @param images 图片数组
/// @param selIndex 选中index
/// @param loadType 需要加载的类型 支持 url 、 file 、 UIImage
- (void)previewImg:(NSArray<UIImage *> *)images andSelIndex:(NSInteger)selIndex andLoadType:(NSString *)loadType {
    NSMutableArray *photos = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [[GKPhoto alloc] init];
        if ([loadType isEqualToString:@"UIImage"]) {
            photo.image = obj;
        } else {
            photo.url = [NSURL URLWithString:obj];
        }
        [photos insertObject:photo atIndex:idx];
    }];
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:selIndex];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    [browser showFromVC:[XToolVC getCurrentViewController]];
}

- (void)showPhotoOrCameraWarnAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

/// 保存图片到相册
/// @param image 图片
/// @param result callback
- (void)saveImageToPhotoAlbumWithImage:(UIImage *)image result:(void (^)(NSMutableDictionary *))result {
    self.saveCallback = result;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized){
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showPhotoOrCameraWarnAlert:@"请在iPhone的“设置-隐私”选项中允许访问你的相册"];
            });
        }
    }];
}

/// 保存图片的回调
/// @param image image
/// @param error error
/// @param contextInfo contextInfo
- (void)image:(UIImage * )image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
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

- (void)uploadImageWithImage:(UIImage *)image result:(void (^)(BOOL))cb {
    if(!self.mediaDelegate){
        //todo
        return;
    }
    // todo upload
//    [_mediaDelegate sendUploadRequestWithUrl:<#(NSString *)#> header:<#(NSDictionary *)#> imageData:<#(NSData *)#> imageName:<#(NSString *)#> success:<#^(NSDictionary *dict)success#> failure:<#^(NSDictionary *dict)failure#>]
}
@end
 
