//
//  xengine__module_dcloud.h
//  dcloud
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "micros.h"
#import "xengine__module_dcloud.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SheetDTO;
@interface __xengine__module_dcloud : xengine__module_dcloud  
 + (instancetype)shareInstance;
-(void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

 -(void)applicationDidBecomeActive:(UIApplication *)application;

 -(void)applicationWillResignActive:(UIApplication *)application;

 -(void)applicationDidEnterBackground:(UIApplication *)application;

 - (void)applicationWillEnterForeground:(UIApplication *)application;

 - (void)applicationWillTerminate:(UIApplication *)application;

 @end

NS_ASSUME_NONNULL_END
