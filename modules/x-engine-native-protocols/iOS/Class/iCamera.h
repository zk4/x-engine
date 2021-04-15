#ifndef icamera_h
#define icamera_h
//
//  icamera.h
//  camera
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#import "JSONModel.h"


@interface CameraParamsDTO: JSONModel
       @property(nonatomic,assign) BOOL allowsEditing;
       @property(nonatomic,assign) BOOL savePhotosAlbum;
       @property(nonatomic,assign) NSInteger cameraFlashMode;
       @property(nonatomic,copy) NSString* cameraDevice;
       @property(nonatomic,assign) BOOL isbase64;
       @property(nonatomic,strong) NSDictionary<NSString*,NSString*>* args;
       @property(nonatomic,assign) NSInteger photoCount;
@end
     
@interface CameraResultDTO: JSONModel
      @property(nonatomic,copy) NSString* retImage;
       @property(nonatomic,copy) NSString* fileName;
       @property(nonatomic,copy) NSString* contentType;
       @property(nonatomic,copy) NSString* width;
       @property(nonatomic,copy) NSString* height;
@end

 

@protocol iCamera <NSObject>

@required
 - (void) openImagePicker:(CameraParamsDTO*) dto success:(void (^)(CameraResultDTO* result))success;

@end

#endif /* icamera_h */
