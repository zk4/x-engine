//
//  xengine__module_model.h
//  model
//
//  Created by 李宫 on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "xengine__module_BaseModule.h"
#import <micros.h>
#import <UIKit/UIKit.h>
@class ZKTYModel;

@interface xengine__module_model : NSObject <UIApplicationDelegate>
-(void)showActionSheet:(ZKTYModel *)model complate:(XEngineCallBack)completionHandler;
@end

