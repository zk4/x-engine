
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_media22.h"


@implementation _previewImg_com_zkty_jsi_media22_0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end

  
@implementation _saveImageToPhotoAlbum_com_zkty_jsi_media22_0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end

  
@implementation _saveImageToPhotoAlbum_com_zkty_jsi_media22_1_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end

  
@implementation _openImagePicker_com_zkty_jsi_media22_0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   
   	return NO;
    }
@end

  
@implementation _openImagePicker_com_zkty_jsi_media22_1_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   
   	return NO;
    }
@end

  
@implementation _openImagePicker_com_zkty_jsi_media22_2_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {	if ([propertyName isEqualToString:@"allowsEditing"]) { return YES; }
   	if ([propertyName isEqualToString:@"savePhotosAlbum"]) { return YES; }
   	if ([propertyName isEqualToString:@"cameraFlashMode"]) { return YES; }
   	if ([propertyName isEqualToString:@"cameraDevice"]) { return YES; }
   
   	if ([propertyName isEqualToString:@"args"]) { return YES; }
   	if ([propertyName isEqualToString:@"photoCount"]) { return YES; }	return NO;
    }
@end

  
@implementation _uploadImage_com_zkty_jsi_media22_0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   
   
   	return NO;
    }
@end

  
@implementation _uploadImage_com_zkty_jsi_media22_1_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   
   	if ([propertyName isEqualToString:@"header"]) { return YES; }	return NO;
    }
@end





  @implementation xengine_jsi_media22
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.jsi.media22";
    }
    
  
  - (id) previewImg:(NSDictionary*) dict {
      
      _previewImg_com_zkty_jsi_media22_0_DTO* dto = [self convert:dict clazz:_previewImg_com_zkty_jsi_media22_0_DTO.class];
      
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return nil;
        }


  [self _previewImg:dto];
         return nil;
}
    - (void) saveImageToPhotoAlbum:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          _saveImageToPhotoAlbum_com_zkty_jsi_media22_1_DTO* dto = [self convert:dict clazz:_saveImageToPhotoAlbum_com_zkty_jsi_media22_1_DTO.class];
          
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return;
        }

          [self _saveImageToPhotoAlbum:dto complete:^(_saveImageToPhotoAlbum_com_zkty_jsi_media22_0_DTO* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
  }
    - (void) openImagePicker:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          _openImagePicker_com_zkty_jsi_media22_2_DTO* dto = [self convert:dict clazz:_openImagePicker_com_zkty_jsi_media22_2_DTO.class];
          
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return;
        }

          [self _openImagePicker:dto complete:^(_openImagePicker_com_zkty_jsi_media22_0_DTO* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
  }
    - (void) uploadImage:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          _uploadImage_com_zkty_jsi_media22_1_DTO* dto = [self convert:dict clazz:_uploadImage_com_zkty_jsi_media22_1_DTO.class];
          
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return;
        }

          [self _uploadImage:dto complete:^(_uploadImage_com_zkty_jsi_media22_0_DTO* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
  }
  @end
