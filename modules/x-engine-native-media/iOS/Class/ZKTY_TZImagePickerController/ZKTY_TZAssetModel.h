//
//  ZKTY_TZAssetModel.h
//  ZKTY_TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef enum : NSUInteger {
    ZKTY_TZAssetModelMediaTypePhoto = 0,
    ZKTY_TZAssetModelMediaTypeLivePhoto,
    ZKTY_TZAssetModelMediaTypePhotoGif,
    ZKTY_TZAssetModelMediaTypeVideo,
    ZKTY_TZAssetModelMediaTypeAudio
} ZKTY_TZAssetModelMediaType;

@class PHAsset;
@interface ZKTY_TZAssetModel : NSObject

@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, assign) BOOL isSelected;      ///< The select status of a photo, default is No
@property (nonatomic, assign) ZKTY_TZAssetModelMediaType type;
@property (nonatomic, copy) NSString *timeLength;
@property (nonatomic, assign) BOOL iCloudFailed;

/// Init a photo dataModel With a PHAsset
/// 用一个PHAsset实例，初始化一个照片模型
+ (instancetype)modelWithAsset:(PHAsset *)asset type:(ZKTY_TZAssetModelMediaType)type;
+ (instancetype)modelWithAsset:(PHAsset *)asset type:(ZKTY_TZAssetModelMediaType)type timeLength:(NSString *)timeLength;

@end


@class PHFetchResult;
@interface ZKTY_TZAlbumModel : NSObject

@property (nonatomic, strong) NSString *name;        ///< The album name
@property (nonatomic, assign) NSInteger count;       ///< Count of photos the album contain
@property (nonatomic, strong) PHFetchResult *result;
@property (nonatomic, strong) PHAssetCollection *collection;
@property (nonatomic, strong) PHFetchOptions *options;

@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSArray *selectedModels;
@property (nonatomic, assign) NSUInteger selectedCount;

@property (nonatomic, assign) BOOL isCameraRoll;

- (void)setResult:(PHFetchResult *)result needFetchAssets:(BOOL)needFetchAssets;
- (void)refreshFetchResult;

@end
