//
//  ScanViewController.h
//  x-engine-native-scan
//
//  Created by cwz on 2021/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ScanCallback)(NSString* _Nullable result);

@interface ScanViewController : UIViewController
@property (nonatomic, copy) ScanCallback callBack;
@end

NS_ASSUME_NONNULL_END
