//
//  JSI_media2.m
//  media2
//


#import "JSI_media2.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import <x-engine-native-media2/iMedia2.h>
#import <x-engine-native-core/XTool.h>
#import <Photos/Photos.h>

// cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface JSI_media2()
@property (nonatomic, strong) id<iMedia2> media;
@property (nonatomic, strong) NSMutableArray *imgCacheArr;
@property (atomic, assign) unsigned long  upload_done_counts;
@end

@implementation JSI_media2
JSI_MODULE(JSI_media2)

- (void)afterAllJSIModuleInited {
    self.media=XENP(iMedia2);
    self.imgCacheArr = [NSMutableArray array];
}


// 预览图片
- (void)_previewImg:(_previewImg_com_zkty_jsi_media2_0_DTO *)dto {
    NSMutableArray *urlList = [NSMutableArray array];
    NSMutableString *loadType = [NSMutableString string];
    [dto.imgList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *uuid = [NSString stringWithFormat:@"%@", obj];
        if ([uuid hasPrefix:@"https://"] || [uuid hasPrefix:@"http://"]) {
            [urlList insertObject:obj atIndex:idx];
            [loadType setString:@"url"];
        } else {
            NSString *localPath = [NSString stringWithFormat:@"file://%@/%@.png", kCachePath,uuid];
            [urlList insertObject:localPath atIndex:idx];
            [loadType setString:@"file"];
        }
    }];
    [self.media previewImgWithUrl:urlList andSelIndex:dto.index];
}


// 保存图片到相册
- (void)_saveImageToPhotoAlbum:(_saveImageToPhotoAlbum_com_zkty_jsi_media2_1_DTO *)dto complete:(void (^)(_saveImageToPhotoAlbum_com_zkty_jsi_media2_0_DTO *, BOOL))completionHandler {
    UIImage *image = [UIImage new];
    NSURL *downloadUrl = [NSURL URLWithString:dto.imageUrl];
    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:downloadUrl]];
    if (image != nil) {
        [self.media saveImageToPhotoAlbumWithImage:image result:^(UIImage *image, NSError *error) {
            _saveImageToPhotoAlbum_com_zkty_jsi_media2_0_DTO *cb = [_saveImageToPhotoAlbum_com_zkty_jsi_media2_0_DTO new];
            if (error) {
                cb.status = -1;
                cb.msg = [NSString stringWithFormat:@"%@", error];
            } else {
                cb.status = 0;
                cb.msg = @"保存成功";
            }
            completionHandler(cb, true);
        }];
    } else {
        @throw @"图片不可为nil";
    }
}

// 打开picker
- (void)_openImagePicker:(_openImagePicker_com_zkty_jsi_media2_2_DTO *)dto complete:(void (^)(_openImagePicker_com_zkty_jsi_media2_0_DTO *, BOOL))completionHandler {
    // 1. 转换 jsi 参数到 native 需要的参数
    Media2ParamsDTO* nativeDto = [Media2ParamsDTO new];
    nativeDto.allowsEditing = dto.allowsEditing;
    nativeDto.args = dto.args;
    nativeDto.cameraDevice = dto.cameraDevice;
    nativeDto.cameraFlashMode = dto.cameraFlashMode;

    [self.media openImagePicker:nativeDto result:^(NSArray<UIImage *> *images, NSArray *assets) {
        _openImagePicker_com_zkty_jsi_media2_0_DTO* jsiRet = [_openImagePicker_com_zkty_jsi_media2_0_DTO new];
        jsiRet.status = 0;
        jsiRet.msg = @"";
        jsiRet.data = [NSMutableArray<_openImagePicker_com_zkty_jsi_media2_1_DTO *><_openImagePicker_com_zkty_jsi_media2_1_DTO> array];
        
        if (assets) {// 相册
            NSArray *array = [self getAlbumWithAssets:assets];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                _openImagePicker_com_zkty_jsi_media2_1_DTO * imgObj = [_openImagePicker_com_zkty_jsi_media2_1_DTO new];
                imgObj.imgID = obj[@"id"];
                imgObj.imgType = obj[@"type"];
                imgObj.thumbnail = obj[@"thumbnail"];
                [jsiRet.data addObject:imgObj];
            }];
        } else {// 相机
            NSArray *array = [self getCameraWithImages:images];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                _openImagePicker_com_zkty_jsi_media2_1_DTO * imgObj = [_openImagePicker_com_zkty_jsi_media2_1_DTO new];
                imgObj.imgID = obj[@"id"];
                imgObj.imgType = obj[@"type"];
                imgObj.thumbnail = obj[@"thumbnail"];
                [jsiRet.data addObject:imgObj];
            }];
        }
        
        completionHandler(jsiRet ,TRUE);
    }];
}

// 获取相机需要返回的数据
- (NSMutableArray *)getCameraWithImages:(NSArray *)images {
    UIImage *originalImage = images[0];
    NSString *type = @"image/png";
    NSString *uuid = [XToolStringConverter uuidString];
    NSString *imgPath = [NSString stringWithFormat:@"%@/%@.png", kCachePath, uuid];
    
    // 将图片移动到cache中 方便之后查找
    [UIImagePNGRepresentation(originalImage) writeToFile:imgPath atomically:YES];
    
    // 存入内存的值
    NSMutableDictionary *toMemoryDict = [NSMutableDictionary dictionary];
    [toMemoryDict setObject:uuid forKey:@"id"];
    [toMemoryDict setObject:type forKey:@"type"];
    [toMemoryDict setObject:imgPath forKey:@"path"];
    [_imgCacheArr addObject:toMemoryDict];
    
    // 返给h5的值
    NSString *base64Str = [XToolImage imageToBase64Str:[XToolImage imageWithImageSimple:originalImage scaledToSize:CGSizeMake(200, 200)]];
    NSMutableDictionary *toH5Dict = [NSMutableDictionary dictionary];
    [toH5Dict setObject:uuid forKey:@"id"];
    [toH5Dict setObject:type forKey:@"type"];
    [toH5Dict setObject:base64Str forKey:@"thumbnail"];
    
    // 返h5
    NSMutableArray *tempSaveArr = [NSMutableArray array];
    [tempSaveArr insertObject:toH5Dict atIndex:0];
    return tempSaveArr;
}

// 获取相册需要返回的数据
- (NSMutableArray *)getAlbumWithAssets:(NSArray *)assets {
    NSMutableArray *tempSaveArr = [NSMutableArray array];
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeExact;
    // 如果图片在icloud上 下面的属性为yes可以获取 如果是no就获取不到
    option.networkAccessAllowed = YES;
    option.synchronous = YES;
    
    for (NSInteger i=0; i<assets.count; i++) {
        PHAsset *asset = assets[i];
        NSMutableDictionary *toH5Dict = [NSMutableDictionary dictionary];
        NSMutableDictionary *toMemoryDict = [NSMutableDictionary dictionary];
        
        NSString *uuid = [XToolStringConverter uuidString];
        // 拼接当前图片的存放路径
        NSString *path = [NSString stringWithFormat:@"%@/%@.png", kCachePath, uuid];
        
        // 获取原图
        [[PHImageManager defaultManager] requestImageForAsset:assets[i] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [UIImagePNGRepresentation(result) writeToFile:path atomically:YES];
        }];
        
        // 获取缩略图
        [[PHImageManager defaultManager] requestImageForAsset:assets[i] targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSString *type = @"image/png";
            NSString *base64Str = [XToolImage imageToBase64Str:result];
            NSString *localIdentifier = asset.localIdentifier;
            
            // 返给h5的值
            [toH5Dict setObject:uuid forKey:@"id"];
            [toH5Dict setObject:type forKey:@"type"];
            [toH5Dict setObject:base64Str forKey:@"thumbnail"];
            
            // 存内存的数据
            [toMemoryDict setObject:uuid forKey:@"id"];
            [toMemoryDict setObject:type forKey:@"type"];
            [toMemoryDict setObject:localIdentifier forKey:@"path"];
        }];
        // 返h5
        [tempSaveArr insertObject:toH5Dict atIndex:i];
        // 存内存
        [_imgCacheArr addObject:toMemoryDict];
    }
    return tempSaveArr;
}

// 上传图片
- (void)_uploadImage:(_uploadImage_com_zkty_jsi_media2_1_DTO *)dto complete:(void (^)(_uploadImage_com_zkty_jsi_media2_0_DTO *, BOOL))completionHandler {
    
    self.upload_done_counts = dto.imgIds.count;
    
    [dto.imgIds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *path = [NSString stringWithFormat:@"file://%@/%@.png", kCachePath,obj];
        NSData *currentImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
        UIImage *image = [UIImage imageWithData:currentImageData];
        NSString *imageName = obj;
        
        self.upload_done_counts--;
        [self.media uploadImageWithUrl:dto.url withImage:image withImageName:imageName success:^(NSDictionary *dict) {
            _uploadImage_com_zkty_jsi_media2_0_DTO *h5CallBack = [_uploadImage_com_zkty_jsi_media2_0_DTO new];
            h5CallBack.status = 0;
            h5CallBack.msg = @"接口发送成功";
            h5CallBack.imgID = imageName;
            h5CallBack.data = [XToolDataConverter dictionaryToJson:dict];
            if(self.upload_done_counts > 0){
                completionHandler(h5CallBack,false);
            } else {
                completionHandler(h5CallBack,true);
            }
        } failure:^(NSString *errorString) {
            _uploadImage_com_zkty_jsi_media2_0_DTO *h5CallBack = [_uploadImage_com_zkty_jsi_media2_0_DTO new];
            h5CallBack.status = -1;
            h5CallBack.msg = errorString;
            h5CallBack.imgID = imageName;
            h5CallBack.data = @"";
            if(self.upload_done_counts > 0){
                completionHandler(h5CallBack,false);
            } else {
                completionHandler(h5CallBack,true);
            }
        }];
    }];
}
@end
