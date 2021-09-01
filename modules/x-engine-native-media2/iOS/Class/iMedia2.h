//
//  iMedia2.h
//  Media2
//

#ifndef iMedia2_h
#define iMedia2_h
#import <UIKit/UIKit.h>
#import <JSONModel.h>
#import "iMedia2Delegate.h"


@interface Media2ParamsDTO: JSONModel
@property(nonatomic,assign) BOOL allowsEditing;
@property(nonatomic,assign) BOOL savePhotosAlbum;
@property(nonatomic,assign) NSInteger cameraFlashMode;
@property(nonatomic,copy) NSString* cameraDevice;
@property(nonatomic,assign) BOOL isbase64;
@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* args;
@property(nonatomic,assign) NSInteger photoCount;
@end

@interface MediaSaveImageDTO: JSONModel
@property(nonatomic,copy) NSString* type;
@property(nonatomic,copy) NSString* imageData;
@end

@protocol iMedia2 <NSObject>
/// 保存图片到相册
/// @param image 图片
/// @param result callback
- (void)saveImageToPhotoAlbumWithImage:(UIImage *)image
                                result:(void (^)(NSMutableDictionary *dict))result;

/// 预览图片
/// @param images 图片数组
/// @param selIndex 选中index
/// @param loadType 需要加载的类型 支持 url 、 file 、 UIImage
- (void)previewImg:(NSArray *)images
       andSelIndex:(NSInteger)selIndex
       andLoadType:(NSString *)loadType;

/// 打开picker
/// @param dto dto
/// @param result result result
- (void)openImagePicker:(Media2ParamsDTO*)dto
                 result:(void (^)(NSArray<UIImage*>* images, NSArray *assets))result;

/// 上传图片
/// @param url url
/// @param image 图片
/// @param imageName 图片名称
/// @param success 成功
/// @param failure 失败
- (void)uploadImageWithUrl:(NSString *)url
                 withImage:(UIImage *)image
             withImageName:(NSString *)imageName
                   success:(void (^)(NSDictionary *dict))success
                   failure:(void (^)(NSString *errorString))failure;

@end
#endif /* iMedia2_h */
