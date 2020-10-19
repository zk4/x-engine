//
//  xengine__module_model.m
//  model
//
//  Created by 李宫 on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "xengine__module_model.h"
#import <XEngineContext.h>
#import <micros.h>
#import <UIViewController+.h>
#import <JSONToDictionary.h>
#import <Unity.h>
#import "ZKTYModel.h"
@implementation xengine__module_model
-(void)showActionSheet:(ZKTYModel *)model complate:(XEngineCallBack)completionHandler{
    
    NSMutableArray *actionHandlers = [NSMutableArray array];
    for (int i = 0; i < model.itemList.count; i++)
    {
        ActionHandler handler = ^(UIAlertAction * _Nonnull action){
            NSLog(@"%d",i);
            completionHandler([NSString stringWithFormat:@"%d",i], YES);
        };
        [actionHandlers addObject:handler];
    }

    [[Unity sharedInstance].getCurrentVC showActionSheetWithTitle:model.title message:model.content cancelTitle:@"取消" sureTitles:model.itemList cancelHandler:^(UIAlertAction * _Nonnull action) {

    } sureHandlers:actionHandlers];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"hello");
    return YES;
}
@end
