//
//  ZKTY_TZAssetCell.h
//  ZKTY_TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef enum : NSUInteger {
    ZKTY_TZAssetCellTypePhoto = 0,
    ZKTY_TZAssetCellTypeLivePhoto,
    ZKTY_TZAssetCellTypePhotoGif,
    ZKTY_TZAssetCellTypeVideo,
    ZKTY_TZAssetCellTypeAudio,
} ZKTY_TZAssetCellType;

@class ZKTY_TZAssetModel;
@interface ZKTY_TZAssetCell : UICollectionViewCell
@property (weak, nonatomic) UIButton *selectPhotoButton;
@property (weak, nonatomic) UIButton *cannotSelectLayerButton;
@property (nonatomic, strong) ZKTY_TZAssetModel *model;
@property (assign, nonatomic) NSInteger index;
@property (nonatomic, copy) void (^didSelectPhotoBlock)(BOOL);
@property (nonatomic, assign) ZKTY_TZAssetCellType type;
@property (nonatomic, assign) BOOL allowPickingGif;
@property (nonatomic, assign) BOOL allowPickingMultipleVideo;
@property (nonatomic, copy) NSString *representedAssetIdentifier;
@property (nonatomic, assign) int32_t imageRequestID;

@property (nonatomic, strong) UIImage *photoSelImage;
@property (nonatomic, strong) UIImage *photoDefImage;

@property (nonatomic, assign) BOOL showSelectBtn;
@property (assign, nonatomic) BOOL allowPreview;

@property (nonatomic, copy) void (^assetCellDidSetModelBlock)(ZKTY_TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView);
@property (nonatomic, copy) void (^assetCellDidLayoutSubviewsBlock)(ZKTY_TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView);
@end


@class ZKTY_TZAlbumModel;
@interface ZKTY_TZAlbumCell : UITableViewCell
@property (nonatomic, strong) ZKTY_TZAlbumModel *model;
@property (weak, nonatomic) UIButton *selectedCountButton;

@property (nonatomic, copy) void (^albumCellDidSetModelBlock)(ZKTY_TZAlbumCell *cell, UIImageView *posterImageView, UILabel *titleLabel);
@property (nonatomic, copy) void (^albumCellDidLayoutSubviewsBlock)(ZKTY_TZAlbumCell *cell, UIImageView *posterImageView, UILabel *titleLabel);
@end


@interface ZKTY_TZAssetCameraCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@end
