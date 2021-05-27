
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_camera.h"


@implementation CameraDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {	if ([propertyName isEqualToString:@"allowsEditing"]) { return YES; }
   	if ([propertyName isEqualToString:@"savePhotosAlbum"]) { return YES; }
   	if ([propertyName isEqualToString:@"cameraFlashMode"]) { return YES; }
   	if ([propertyName isEqualToString:@"cameraDevice"]) { return YES; }
   
   
   	if ([propertyName isEqualToString:@"photoCount"]) { return YES; }
   	return NO;
    }
@end
    
  
@implementation CameraRetDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   
   
   
   	return NO;
    }
@end
    
  
@implementation SaveImageDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end
    




  @implementation xengine_jsi_camera
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.module.camera";
    }
    
    - (void) openImagePicker:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          CameraDTO* dto = [self convert:dict clazz:CameraDTO.class];
          [self _openImagePicker:dto complete:^(CameraRetDTO* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
    - (void) saveImageToAlbum:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          SaveImageDTO* dto = [self convert:dict clazz:SaveImageDTO.class];
          [self _saveImageToAlbum:dto complete:^(BOOL complete) {
             completionHandler(nil ,complete);
          }];
      }
  @end
