//
//  BEANAppDelegate.m
//  UniBoost
//
//  Created by Ash on 07/21/2020.
//  Copyright (c) 2020 Ash. All rights reserved.
//

#import "BEANAppDelegate.h"
#import "DCUniMP.h"
#import "WeexSDK.h"

@implementation BEANAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // 配置参数
       NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:launchOptions];
       // 设置 debug YES 会在控制台输出 js log，默认不输出 log，注：需要引入 liblibLog.a 库
       [options setObject:[NSNumber numberWithBool:YES] forKey:@"debug"];
       // 初始化引擎
       [DCUniMPSDKEngine initSDKEnvironmentWihtLaunchOptions:options];
    
    
//    // 注册 module 注：module的 Name 需要保证唯一， class：为 module 的类名
       [WXSDKEngine registerModule:@"TestModule" withClass:NSClassFromString(@"TestModule")];
       // 注册 component 注：component 的 Name 需要保证唯一， class：为 component 的类名
       [WXSDKEngine registerComponent:@"testmap" withClass:NSClassFromString(@"TestMapComponent")];
    return YES;
}

#pragma mark - App 生命周期方法
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidBecomeActive:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [DCUniMPSDKEngine destory];
}


@end
