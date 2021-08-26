
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol _previewImg0_DTO;
@protocol SaveAblumDTO;
@protocol _saveImageToPhotoAlbum0_DTO;
@protocol _openImagePicker0_DTO;
@protocol _uploadImage0_DTO;
@class _previewImg0_DTO;
@class SaveAblumDTO;
@class _saveImageToPhotoAlbum0_DTO;
@class _openImagePicker0_DTO;
@class _uploadImage0_DTO;

@interface _previewImg0_DTO: JSONModel
  	@property(nonatomic,assign) NSInteger index;
   	@property(nonatomic,strong) NSArray<NSString*>* imgList;
@end


@interface SaveAblumDTO: JSONModel
  	@property(nonatomic,assign) NSInteger status;
   	@property(nonatomic,copy) NSString* msg;
@end


@interface _saveImageToPhotoAlbum0_DTO: JSONModel
  	@property(nonatomic,copy) NSString* type;
   	@property(nonatomic,copy) NSString* imageData;
@end


@interface _openImagePicker0_DTO: JSONModel
  	@property(nonatomic,assign) BOOL allowsEditing;
   	@property(nonatomic,assign) BOOL savePhotosAlbum;
   	@property(nonatomic,assign) NSInteger cameraFlashMode;
   	@property(nonatomic,copy) NSString* cameraDevice;
   	@property(nonatomic,assign) BOOL isbase64;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* args;
   	@property(nonatomic,assign) NSInteger photoCount;
@end


@interface _uploadImage0_DTO: JSONModel
  	@property(nonatomic,copy) NSString* url;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* header;
   	@property(nonatomic,strong) NSArray* ids;
@end



@protocol xengine_jsi_media_protocol
   @required 
    - (void) _previewImg:(_previewImg0_DTO*)dto;

   @required 
     - (void) _saveImageToPhotoAlbum:(_saveImageToPhotoAlbum0_DTO*) dto complete:(void (^)(SaveAblumDTO* result,BOOL complete)) completionHandler;

   @required 
     - (void) _openImagePicker:(_openImagePicker0_DTO*) dto complete:(void (^)(NSString* result,BOOL complete)) completionHandler;

   @required 
     - (void) _uploadImage:(_uploadImage0_DTO*) dto complete:(void (^)(NSString* result,BOOL complete)) completionHandler;

@end



@interface xengine_jsi_media : JSIModule<xengine_jsi_media_protocol>
@end

