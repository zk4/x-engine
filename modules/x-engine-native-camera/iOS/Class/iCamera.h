//
//  icamera.h
//  camera
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#import "JSONModel.h"
#ifndef icamera_h
#define icamera_h


@interface CameraDTO: JSONModel
       @property(nonatomic,assign) BOOL allowsEditing;
       @property(nonatomic,assign) BOOL savePhotosAlbum;
       @property(nonatomic,assign) NSInteger cameraFlashMode;
       @property(nonatomic,copy) NSString* cameraDevice;
       @property(nonatomic,assign) BOOL isbase64;
       @property(nonatomic,strong) NSDictionary<NSString*,NSString*>* args;
       @property(nonatomic,assign) NSInteger photoCount;
@end
    

@implementation CameraDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {    if ([propertyName isEqualToString:@"allowsEditing"]) { return YES; }
       if ([propertyName isEqualToString:@"savePhotosAlbum"]) { return YES; }
       if ([propertyName isEqualToString:@"cameraFlashMode"]) { return YES; }
       if ([propertyName isEqualToString:@"cameraDevice"]) { return YES; }
   
   
       if ([propertyName isEqualToString:@"photoCount"]) { return YES; }
       return NO;
    }
@end


@interface CameraRetDTO: JSONModel
      @property(nonatomic,copy) NSString* retImage;
       @property(nonatomic,copy) NSString* fileName;
       @property(nonatomic,copy) NSString* contentType;
       @property(nonatomic,copy) NSString* width;
       @property(nonatomic,copy) NSString* height;
@end


@implementation CameraRetDTO
  + (BOOL)propertyIsOptional:(NSString *)propertyName {
     return NO;
  }
@end

@protocol iCamera <NSObject>

@required
 - (void) openImagePicker:(CameraDTO*) dto succeccful:(void (^)(CameraRetDTO* result)) succeccful;

@end

#endif /* icamera_h */
