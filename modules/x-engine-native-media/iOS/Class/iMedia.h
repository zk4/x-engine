//
//  iMedia.h
//  x-engine-native-media
//
//  Created by cwz on 2021/8/18.
//

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

@interface MediaPhotoListDTO: JSONModel
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,copy) NSArray* imgList;
@end

@protocol iMedia <NSObject>
@required
- (void)openImagePicker:(MediaParamsDTO*) dto result:(void (^)(NSDictionary* dict))result;

- (void)saveImageToPhotoAlbum:(MediaSaveImageDTO *)dto result:(void (^)(int result))result;

- (void)previewImg:(MediaPhotoListDTO * )dto;

- (void)uploadImageWithUrl:(NSString *)url WithHeader:(NSDictionary *)header WithImageList:(NSArray *)imageList result:(void (^)(NSDictionary *dict))result;
@end

#endif
