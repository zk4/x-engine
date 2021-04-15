//
//  ZKTY_TZPhotoPickerController.h
//  ZKTY_TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKTY_TZAlbumModel;
@interface ZKTY_TZPhotoPickerController : UIViewController

@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, assign) NSInteger columnNumber;
@property (nonatomic, strong) ZKTY_TZAlbumModel *model;
@end


@interface ZKTY_TZCollectionView : UICollectionView

@end
