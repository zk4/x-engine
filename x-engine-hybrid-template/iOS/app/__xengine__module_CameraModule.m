//
//  __xengine__module_CameraModule.m
//  XEngineSDKDemo
//
//  Created by edz on 2020/7/29.
//  Copyright © 2020 edz. All rights reserved.
//

#import "__xengine__module_CameraModule.h"
#import <TZImagePickerController.h>

@interface __xengine__module_CameraModule() <TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@end

@implementation __xengine__module_CameraModule

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = [Unity sharedInstance].getCurrentVC.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = [Unity sharedInstance].getCurrentVC.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
        BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
//        if (@available(iOS 9, *)) {
//            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
//            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
//        } else {
//            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
//            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
//        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
 
    }
    return _imagePickerVc;
}

- (void)pushTZImagePickerController
{
     TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"photos ===== %@",photos);
        NSLog(@"photos ===== %@",assets);
        NSLog(@"isSelectOriginalPhoto ===== %d",isSelectOriginalPhoto);
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [[Unity sharedInstance].getCurrentVC presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)startCamera:(NSDictionary *)data callBack:(XEngineCallBack)completionHandler
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self takePhoto];
    }];
    [alertVc addAction:takePhotoAction];
    UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushTZImagePickerController];
    }];
    [alertVc addAction:imagePickerAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:cancelAction];
    [[Unity sharedInstance].getCurrentVC presentViewController:alertVc animated:YES completion:nil];
}

@end
