//
//  QRCodeBacgrouView.h
//  testSingature
//
//  Created by jabraknight on 2021/8/9.
//  Copyright © 2021 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeScanPreviewView : UIView<UIGestureRecognizerDelegate>
@property(nonatomic,assign)CGRect scanFrame;
@property(nonatomic,assign)CGFloat effectiveScale;
@property(nonatomic,assign)CGFloat beginGestureScale;

@end

NS_ASSUME_NONNULL_END
