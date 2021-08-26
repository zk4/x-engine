//
//  JSI_media.m
//  media
//


#import "JSI_media.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iMedia.h"

@interface JSI_media()
@property (nonatomic, strong) id<iMedia> media;
@property (atomic, assign) unsigned long  upload_done_counts;
@end

@implementation JSI_media
JSI_MODULE(JSI_media)

- (void)afterAllJSIModuleInited {
    self.media = XENP(iMedia);
}

- (void)_openImagePicker:(_openImagePicker0_DTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    MediaParamsDTO *model = [MediaParamsDTO new];
    model.allowsEditing = dto.allowsEditing;
    model.savePhotosAlbum = dto.savePhotosAlbum;
    model.cameraFlashMode = dto.cameraFlashMode;
    model.cameraDevice = dto.cameraDevice;
    model.isbase64 = dto.isbase64;
    model.args = dto.args;
    model.photoCount = dto.photoCount;
    [self.media openImagePicker:model result:^(NSDictionary *result) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        completionHandler(dataString, TRUE);
    }];
}

- (void)_saveImageToPhotoAlbum:(_saveImageToPhotoAlbum1_DTO *)dto complete:(void (^)(_saveImageToPhotoAlbum0_DTO*, BOOL))completionHandler {
    MediaSaveImageDTO *model = [MediaSaveImageDTO new];
    model.type = dto.type;
    model.imageData = dto.imageData;
    [self.media saveImageToPhotoAlbum:model result:^(int result) {
        _saveImageToPhotoAlbum0_DTO *dto = [_saveImageToPhotoAlbum0_DTO new];
        dto.status = result;
        completionHandler(dto, TRUE);
    }];
}

- (void)_previewImg:(_previewImg0_DTO *)dto {
    MediaPhotoListDTO *model = [MediaPhotoListDTO new];
    model.index = dto.index;
    model.imgList = dto.imgList;
    [self.media previewImg:model];
}

- (void)_uploadImage:(_uploadImage0_DTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    self.upload_done_counts = dto.ids.count;
    [self.media uploadImageWithUrl:dto.url WithHeader:dto.header WithImageList:dto.ids result:^(NSDictionary *result) {
        self.upload_done_counts--;
        if(self.upload_done_counts > 0){
            completionHandler([self dictionaryToJson:result], false);
        }else{
            completionHandler([self dictionaryToJson:result], true);
        }
    }];
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
