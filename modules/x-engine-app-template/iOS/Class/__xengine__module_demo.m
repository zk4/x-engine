//
//  xengine__module_demo.m
//  demo
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_demo.h"
#import <XEngineContext.h>
#import <micros.h>
#import <UIViewController+.h>
#import <JSONToDictionary.h>
#import <RecyleWebViewController.h>
#import <XEngineWebView.h>
#import <Unity.h>

@interface __xengine__module_demo()
@end

@implementation __xengine__module_demo
 
 

//- (void)_hello2:(SheetDTO *)dto complete:(void (^)(MoreDTO*, BOOL))completionHandler {
//         NSLog(@"%@",dto);
//
//    NSMutableArray *actionHandlers = [NSMutableArray array];
//    for (int i = 0; i < dto.itemList.count; i++)
//    {
//        ActionHandler handler = ^(UIAlertAction * _Nonnull action){
//            NSLog(@"%d",i);
//            MoreDTO* d = [MoreDTO new];
//            d.title=[NSString stringWithFormat:@"%d",i];
//            completionHandler(d, YES);
//        };
//        [actionHandlers addObject:handler];
//    }
//    UIViewController*  cvc = [Unity sharedInstance].getCurrentVC;
//
//    [cvc showActionSheetWithTitle:dto.title message:dto.content cancelTitle:@"取消" sureTitles:dto.itemList cancelHandler:^(UIAlertAction * _Nonnull action) {
//
//    } sureHandlers:actionHandlers];
//
//}

 
  

- (void)_abc:(NSString *)dto complete:(void (^)(BOOL))completionHandler {
    NSLog(@"%@",dto);
}

- (void)_haveArgNoRet:(SheetDTO *)dto complete:(void (^)(BOOL))completionHandler {
    
}

- (void)_haveArgRetPrimitive:(SheetDTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    
}

- (void)_haveArgRetSheetDTO:(SheetDTO *)dto complete:(void (^)(SheetDTO *, BOOL))completionHandler {
    
}

- (void)_noArgNoRet:(void (^)(BOOL))completionHandler {
    
}

- (void)_noArgRetPrimitive:(void (^)(NSString *, BOOL))completionHandler {
    
}

- (void)_noArgRetSheetDTO:(void (^)(SheetDTO *, BOOL))completionHandler {
    
}

- (void)_showActionSheet:(SheetDTO *)dto complete:(void (^)(BOOL))completionHandler {
        NSMutableArray *actionHandlers = [NSMutableArray array];
        for (int i = 0; i < dto.itemList.count; i++)
        {
            ActionHandler handler = ^(UIAlertAction * _Nonnull action){
                NSLog(@"%d",i);
                [self callJsByFuncName:dto.__event__ arguments:@[@(i),@(i)] completionHandler:nil];
            };
            [actionHandlers addObject:handler];
        }
        UIViewController*  cvc = [Unity sharedInstance].getCurrentVC;
    
        [cvc showActionSheetWithTitle:dto.title message:dto.content cancelTitle:@"取消" sureTitles:dto.itemList cancelHandler:^(UIAlertAction * _Nonnull action) {} sureHandlers:actionHandlers];
        completionHandler(YES);
}









@end
 
