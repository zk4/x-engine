//
//  ZKTY_TZImageRequestOperation.h
//  ZKTY_TZImagePickerControllerFramework
//
//  Created by 谭真 on 2018/12/20.
//  Copyright © 2018 谭真. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKTY_TZImageRequestOperation : NSOperation

typedef void(^ZKTY_TZImageRequestCompletedBlock)(UIImage *photo, NSDictionary *info, BOOL isDegraded);
typedef void(^ZKTY_TZImageRequestProgressBlock)(double progress, NSError *error, BOOL *stop, NSDictionary *info);

@property (nonatomic, copy, nullable) ZKTY_TZImageRequestCompletedBlock completedBlock;
@property (nonatomic, copy, nullable) ZKTY_TZImageRequestProgressBlock progressBlock;
@property (nonatomic, strong, nullable) PHAsset *asset;

@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;

- (instancetype)initWithAsset:(PHAsset *)asset completion:(ZKTY_TZImageRequestCompletedBlock)completionBlock progressHandler:(ZKTY_TZImageRequestProgressBlock)progressHandler;
- (void)done;
@end

NS_ASSUME_NONNULL_END
