//
//  ZKTYScanViewController.h
//  motherboard
//
//  Created by 李宫 on 2020/10/27.
//  Copyright © 2020 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetScanDataBlock)(NSString *data);

@interface ZKTYScanViewController : UIViewController

@property (nonatomic, copy) GetScanDataBlock block;

@end

