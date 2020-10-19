//
//  __xengine__module_UIModule.m
//  UIModule
//
//  Created by edz on 2020/7/21.
//  Copyright © 2020 edz. All rights reserved.
//

#import "__xengine__module_UIModule.h"
#import "XEngineContext.h"
#import <UIViewController+.h>
#import "Unity.h"
#import "JSONToDictionary.h"
@implementation __xengine__module_UIModule
#pragma mark - HUD

- (instancetype)init
{
    self = [super init];

    return self;
}

- (NSString *)moduleId
{
    return @"com.zkty.module.engine";
}
- (void)showActionSheet:(NSDictionary *)param complate:(XEngineCallBack)completionHandler
{

    NSString *title = param[@"title"];
    NSString *message = param[@"content"];
    NSArray *itemList = param[@"itemList"];
    NSMutableArray *actionHandlers = [NSMutableArray array];
    for (int i = 0; i < itemList.count; i++)
    {
        ActionHandler handler = ^(UIAlertAction * _Nonnull action){
            NSLog(@"%d",i);
            completionHandler([NSString stringWithFormat:@"%d",i], YES);
        };
        [actionHandlers addObject:handler];
    }
    
    [[Unity sharedInstance].getCurrentVC showActionSheetWithTitle:title message:message cancelTitle:@"取消" sureTitles:itemList cancelHandler:^(UIAlertAction * _Nonnull action) {
        
    } sureHandlers:actionHandlers];
}

- (void)hideActionSheet:(NSDictionary *)param complate:(XEngineCallBack)completionHandler
{

    [[Unity sharedInstance].getCurrentVC dismissViewControllerAnimated:YES completion:nil];
     completionHandler([NSString stringWithFormat:@"%d",2], YES);
}
@end
