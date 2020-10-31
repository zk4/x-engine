
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import <xengine__module_BaseModule.h>
#import "JSONModel.h"

@protocol CameraDTO;
@protocol CameraRetDTO;

@interface CameraDTO: JSONModel
  	@property(nonatomic,assign) BOOL allowsEditing;
   	@property(nonatomic,assign) BOOL savePhotosAlbum;
   	@property(nonatomic,assign) NSInteger cameraFlashMode;
   	@property(nonatomic,copy) NSString* cameraDevice;
   	@property(nonatomic,assign) BOOL isbase64;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* args;
   	@property(nonatomic,strong) NSString* __event__;
@end
    

@interface CameraRetDTO: JSONModel
  	@property(nonatomic,copy) NSString* retImage;
@end
    


@protocol xengine__module_camera_protocol
       @required 
        - (void) _openImagePicker:(CameraDTO*) dto complete:(void (^)(CameraRetDTO* result,BOOL complete)) completionHandler;

@end
  


@interface xengine__module_camera : xengine__module_BaseModule<xengine__module_camera_protocol>
@end

