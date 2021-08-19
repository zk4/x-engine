//
//  iMedia.h
//  x-engine-native-media
//
//  Created by cwz on 2021/8/18.
//


//#import "JSONModel.h"
//
//
//#import <Foundation/Foundation.h>
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface iMedia : NSObject
//
//@end
//
//NS_ASSUME_NONNULL_END

#ifndef imedia_h
#define imedia_h
#import "JSONModel.h"

@interface MediaParamsDTO: JSONModel
@property(nonatomic,assign) BOOL allowsEditing;
@property(nonatomic,assign) BOOL savePhotosAlbum;
@property(nonatomic,assign) NSInteger cameraFlashMode;
@property(nonatomic,copy) NSString* cameraDevice;
@property(nonatomic,assign) BOOL isbase64;
@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* args;
@property(nonatomic,assign) NSInteger photoCount;
@end

@interface MediaResultDTO: JSONModel
@property(nonatomic,copy) NSString* retImage;
@property(nonatomic,copy) NSString* fileName;
@property(nonatomic,copy) NSString* contentType;
@property(nonatomic,copy) NSString* width;
@property(nonatomic,copy) NSString* height;
@end

@interface MediaSaveImageDTO: JSONModel
@property(nonatomic,copy) NSString* type;
@property(nonatomic,copy) NSString* imageData;
@end

@protocol iMedia <NSObject>
@required
- (void)openImagePicker:(MediaParamsDTO*) dto success:(void (^)(NSString* result))success;

- (void)saveImageToPhotoAlbum:(MediaSaveImageDTO *)dto saveSuccess:(void (^)(NSString* result))success;

- (void)previewImg;
@end

#endif
