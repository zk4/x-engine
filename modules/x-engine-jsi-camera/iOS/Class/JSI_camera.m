//
//  JSI_camera.m
//  camera
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_camera.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iCamera.h"

@interface JSI_camera()
@property(nonatomic,strong) id<iCamera> camera;
@end

@implementation JSI_camera
JSI_MODULE(JSI_camera)

- (void)afterAllJSIModuleInited {
    self.camera = XENP(iCamera);
}

- (void)_openImagePicker:(_openImagePicker_com_zkty_jsi_camera_0_DTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    CameraParamsDTO *model = [CameraParamsDTO new];
    model.allowsEditing = dto.allowsEditing;
    model.savePhotosAlbum = dto.savePhotosAlbum;
    model.cameraFlashMode = dto.cameraFlashMode;
    model.cameraDevice = dto.cameraDevice;
    model.isbase64 = dto.isbase64;
    model.args = dto.args;
    model.photoCount = dto.photoCount;
    [self.camera openImagePicker:model success:^(NSString *result) {
        completionHandler(result, TRUE);
    }];
}
 
- (void)_saveImageToPhotoAlbum:(_saveImageToPhotoAlbum_com_zkty_jsi_camera_0_DTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    SaveImageDTO *model = [SaveImageDTO new];
    model.type = dto.type;
    model.imageData = dto.imageData;
    [self.camera saveImageToPhotoAlbum:model saveSuccess:^(NSString *result) {
        completionHandler(result, TRUE);
    }];
}
 
 
 
 

@end
