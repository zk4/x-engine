//
//  JSI_camera.m
//  camera
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_camera.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "iCamera.h"

@interface JSI_camera()
@property(nonatomic,strong) id<iCamera> camera;
@end

@implementation JSI_camera
JSI_MODULE(JSI_camera)

- (void)afterAllJSIModuleInited {
    self.camera = XENP(iCamera);
}

- (void)_openImagePicker:(_1_com_zkty_jsi_camera_DTO *)dto complete:(void (^)(_0_com_zkty_jsi_camera_DTO *, BOOL))completionHandler {
    
    CameraParamsDTO *model = [CameraParamsDTO new];
    model.allowsEditing = dto.allowsEditing;
    model.savePhotosAlbum = dto.savePhotosAlbum;
    model.cameraFlashMode = dto.cameraFlashMode;
    model.cameraDevice = dto.cameraDevice;
    model.isbase64 = dto.isbase64;
    model.args = dto.args;
    model.photoCount = dto.photoCount;
    
    [self.camera openImagePicker:model success:^(CameraResultDTO *result) {
        _0_com_zkty_jsi_camera_DTO *model = [_0_com_zkty_jsi_camera_DTO new];
        model.retImage = result.retImage;
        model.fileName = result.fileName;
        model.contentType = result.contentType;
        model.width = result.width;
        model.height = result.height;
        completionHandler(model, TRUE);
    }];
}

- (void)_saveImageToPhotoAlbum:(_2_com_zkty_jsi_camera_DTO *)dto {
    SaveImageDTO *model = [SaveImageDTO new];
    model.type = dto.type;
    model.imageData = dto.imageData;    
    [self.camera saveImageToPhotoAlbum:model];
}
@end
