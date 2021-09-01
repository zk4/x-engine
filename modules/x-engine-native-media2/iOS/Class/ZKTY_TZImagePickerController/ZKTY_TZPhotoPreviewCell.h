//
//  ZKTY_TZPhotoPreviewCell.h
//  ZKTY_TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKTY_TZAssetModel;
@interface ZKTY_TZAssetPreviewCell : UICollectionViewCell
@property (nonatomic, strong) ZKTY_TZAssetModel *model;
@property (nonatomic, copy) void (^singleTapGestureBlock)(void);
- (void)configSubviews;
- (void)photoPreviewCollectionViewDidScroll;
@end


@class ZKTY_TZAssetModel,ZKTY_TZProgressView,ZKTY_TZPhotoPreviewView;
@interface ZKTY_TZPhotoPreviewCell : ZKTY_TZAssetPreviewCell

@property (nonatomic, copy) void (^imageProgressUpdateBlock)(double progress);

@property (nonatomic, strong) ZKTY_TZPhotoPreviewView *previewView;

@property (nonatomic, assign) BOOL allowCrop;
@property (nonatomic, assign) CGRect cropRect;
@property (nonatomic, assign) BOOL scaleAspectFillCrop;

- (void)recoverSubviews;

@end


@interface ZKTY_TZPhotoPreviewView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imageContainerView;
@property (nonatomic, strong) ZKTY_TZProgressView *progressView;
@property (nonatomic, strong) UIImageView *iCloudErrorIcon;
@property (nonatomic, strong) UILabel *iCloudErrorLabel;
@property (nonatomic, copy) void (^iCloudSyncFailedHandle)(id asset, BOOL isSyncFailed);


@property (nonatomic, assign) BOOL allowCrop;
@property (nonatomic, assign) CGRect cropRect;
@property (nonatomic, assign) BOOL scaleAspectFillCrop;
@property (nonatomic, strong) ZKTY_TZAssetModel *model;
@property (nonatomic, strong) id asset;
@property (nonatomic, copy) void (^singleTapGestureBlock)(void);
@property (nonatomic, copy) void (^imageProgressUpdateBlock)(double progress);

@property (nonatomic, assign) int32_t imageRequestID;

- (void)recoverSubviews;
@end


@class AVPlayer, AVPlayerLayer;
@interface ZKTY_TZVideoPreviewCell : ZKTY_TZAssetPreviewCell
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIImage *cover;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) UIImageView *iCloudErrorIcon;
@property (nonatomic, strong) UILabel *iCloudErrorLabel;
@property (nonatomic, copy) void (^iCloudSyncFailedHandle)(id asset, BOOL isSyncFailed);
- (void)pausePlayerAndShowNaviBar;
@end


@interface ZKTY_TZGifPreviewCell : ZKTY_TZAssetPreviewCell
@property (strong, nonatomic) ZKTY_TZPhotoPreviewView *previewView;
@end
