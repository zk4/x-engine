//
//  ZKScanViewController.h
//  scan
//
//  Created by 吕冬剑 on 2020/10/14.
//  Copyright © 2020 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetScanDataBlock)(NSString *data);

@interface ZKScanViewController : UIViewController

@property (nonatomic, copy) GetScanDataBlock block;

@end


