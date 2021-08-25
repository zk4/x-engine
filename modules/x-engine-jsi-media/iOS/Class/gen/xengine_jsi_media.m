
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_media.h"


@implementation _previewImg0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end

  
@implementation _openImagePicker0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {	if ([propertyName isEqualToString:@"allowsEditing"]) { return YES; }
   	if ([propertyName isEqualToString:@"savePhotosAlbum"]) { return YES; }
   	if ([propertyName isEqualToString:@"cameraFlashMode"]) { return YES; }
   	if ([propertyName isEqualToString:@"cameraDevice"]) { return YES; }
   
   	if ([propertyName isEqualToString:@"args"]) { return YES; }
   	if ([propertyName isEqualToString:@"photoCount"]) { return YES; }	return NO;
    }
@end

  
@implementation _saveImageToPhotoAlbum0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end

  
@implementation _uploadImage0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   
   	return NO;
    }
@end





  @implementation xengine_jsi_media
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.jsi.media";
    }
    
  
  - (id) previewImg:(NSDictionary*) dict {
      
      _previewImg0_DTO* dto = [self convert:dict clazz:_previewImg0_DTO.class];
      
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
        }


  [self _previewImg:dto];
         return nil;
}
    - (void) openImagePicker:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          _openImagePicker0_DTO* dto = [self convert:dict clazz:_openImagePicker0_DTO.class];
          
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return;
        }

          [self _openImagePicker:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
  }
    - (void) saveImageToPhotoAlbum:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          _saveImageToPhotoAlbum0_DTO* dto = [self convert:dict clazz:_saveImageToPhotoAlbum0_DTO.class];
          
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return;
        }

          [self _saveImageToPhotoAlbum:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
  }
    - (void) uploadImage:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          _uploadImage0_DTO* dto = [self convert:dict clazz:_uploadImage0_DTO.class];
          
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return;
        }

          [self _uploadImage:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
  }
  @end
