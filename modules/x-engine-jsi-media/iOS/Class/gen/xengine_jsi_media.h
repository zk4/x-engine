
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol _previewImg0_DTO;
@protocol _saveImageToPhotoAlbum0_DTO;
@protocol _saveImageToPhotoAlbum1_DTO;
@protocol _openImagePicker0_DTO;
@protocol _openImagePicker1_DTO;
@protocol _openImagePicker2_DTO;
@protocol _uploadImage0_DTO;
@protocol _uploadImage1_DTO;
@class _previewImg0_DTO;
@class _saveImageToPhotoAlbum0_DTO;
@class _saveImageToPhotoAlbum1_DTO;
@class _openImagePicker0_DTO;
@class _openImagePicker1_DTO;
@class _openImagePicker2_DTO;
@class _uploadImage0_DTO;
@class _uploadImage1_DTO;

@interface _previewImg0_DTO: JSONModel
  	@property(nonatomic,assign) NSInteger index;
   	@property(nonatomic,strong) NSMutableArray<NSString*>* imgList;
@end


@interface _saveImageToPhotoAlbum0_DTO: JSONModel
  	@property(nonatomic,assign) NSInteger status;
   	@property(nonatomic,copy) NSString* msg;
@end


@interface _saveImageToPhotoAlbum1_DTO: JSONModel
  	@property(nonatomic,copy) NSString* type;
   	@property(nonatomic,copy) NSString* imageData;
@end


@interface _openImagePicker0_DTO: JSONModel
  	@property(nonatomic,assign) NSInteger status;
   	@property(nonatomic,copy) NSString* msg;
   	@property(nonatomic,strong) NSMutableArray<_openImagePicker1_DTO*><_openImagePicker1_DTO>* data;
@end


@interface _openImagePicker1_DTO: JSONModel
  	@property(nonatomic,copy) NSString* imgID;
   	@property(nonatomic,copy) NSString* type;
   	@property(nonatomic,copy) NSString* thumbnail;
@end


@interface _openImagePicker2_DTO: JSONModel
  	@property(nonatomic,assign) BOOL allowsEditing;
   	@property(nonatomic,assign) BOOL savePhotosAlbum;
   	@property(nonatomic,assign) NSInteger cameraFlashMode;
   	@property(nonatomic,copy) NSString* cameraDevice;
   	@property(nonatomic,assign) BOOL isbase64;
   	@property(nonatomic,strong) NSMutableDictionary<NSString*,NSString*>* args;
   	@property(nonatomic,assign) NSInteger photoCount;
@end


@interface _uploadImage0_DTO: JSONModel
  	@property(nonatomic,assign) NSInteger status;
   	@property(nonatomic,copy) NSString* msg;
   	@property(nonatomic,copy) NSString* imgID;
   	@property(nonatomic,strong) NSMutableDictionary<NSString*,NSString*>* data;
@end


@interface _uploadImage1_DTO: JSONModel
  	@property(nonatomic,copy) NSString* url;
   	@property(nonatomic,strong) NSMutableDictionary<NSString*,NSString*>* header;
   	@property(nonatomic,strong) NSMutableArray* ids;
@end



@protocol xengine_jsi_media_protocol
   @required 
    - (void) _previewImg:(_previewImg0_DTO*)dto;

   @required 
     - (void) _saveImageToPhotoAlbum:(_saveImageToPhotoAlbum1_DTO*) dto complete:(void (^)(_saveImageToPhotoAlbum0_DTO* result,BOOL complete)) completionHandler;

   @required 
     - (void) _openImagePicker:(_openImagePicker2_DTO*) dto complete:(void (^)(_openImagePicker0_DTO* result,BOOL complete)) completionHandler;

   @required 
     - (void) _uploadImage:(_uploadImage1_DTO*) dto complete:(void (^)(_uploadImage0_DTO* result,BOOL complete)) completionHandler;

@end



@interface xengine_jsi_media : JSIModule<xengine_jsi_media_protocol>
@end

