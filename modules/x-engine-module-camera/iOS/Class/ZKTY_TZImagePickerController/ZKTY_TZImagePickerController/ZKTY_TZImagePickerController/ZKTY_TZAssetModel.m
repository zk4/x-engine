//
//  ZKTY_TZAssetModel.m
//  ZKTY_TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import "ZKTY_TZAssetModel.h"
#import "ZKTY_TZImageManager.h"

@implementation ZKTY_TZAssetModel

+ (instancetype)modelWithAsset:(PHAsset *)asset type:(ZKTY_TZAssetModelMediaType)type{
    ZKTY_TZAssetModel *model = [[ZKTY_TZAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}

+ (instancetype)modelWithAsset:(PHAsset *)asset type:(ZKTY_TZAssetModelMediaType)type timeLength:(NSString *)timeLength {
    ZKTY_TZAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}

@end



@implementation ZKTY_TZAlbumModel

- (void)setResult:(PHFetchResult *)result needFetchAssets:(BOOL)needFetchAssets {
    _result = result;
    if (needFetchAssets) {
        [[ZKTY_TZImageManager manager] getAssetsFromFetchResult:result completion:^(NSArray<ZKTY_TZAssetModel *> *models) {
            self->_models = models;
            if (self->_selectedModels) {
                [self checkSelectedModels];
            }
        }];
    }
}

- (void)refreshFetchResult {
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:self.collection options:self.options];
    self.count = fetchResult.count;
    [self setResult:fetchResult];
}

- (void)setSelectedModels:(NSArray *)selectedModels {
    _selectedModels = selectedModels;
    if (_models) {
        [self checkSelectedModels];
    }
}

- (void)checkSelectedModels {
    self.selectedCount = 0;
    NSMutableSet *selectedAssets = [NSMutableSet setWithCapacity:_selectedModels.count];
    for (ZKTY_TZAssetModel *model in _selectedModels) {
        [selectedAssets addObject:model.asset];
    }
    for (ZKTY_TZAssetModel *model in _models) {
        if ([selectedAssets containsObject:model.asset]) {
            self.selectedCount ++;
        }
    }
}

- (NSString *)name {
    if (_name) {
        return _name;
    }
    return @"";
}

@end
