//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import <XEngineContext.h>
#import "ZYDL_TabBarController.h"
#import "DCUniMP.h"
#import "WeexSDK.h"
#import "__xengine__module_dcloud.h"
#import "ZKLogViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)redirectNotificationHandle:(NSNotification *)nf{
    NSData *data = [[nf userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"inputTextValueChangedNotification" object:nil userInfo:@{@"inputText": str}];
    ZKLogViewController * log = [[ZKLogViewController alloc]init];

    [[nf object] readInBackgroundAndNotify];
}
  
- (void)redirectSTD:(int )fd{
  NSPipe * pipe = [NSPipe pipe] ;
  NSFileHandle *pipeReadHandle = [pipe fileHandleForReading] ;
  dup2([[pipe fileHandleForWriting] fileDescriptor], fd) ;
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(redirectNotificationHandle:)
                                               name:NSFileHandleReadCompletionNotification
                                             object:pipeReadHandle] ;
  [pipeReadHandle readInBackgroundAndNotify];
}
+ (void)load
{
    // 有意思, 像 java
    NSLog(@"hello ,world");

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self redirectSTD:STDOUT_FILENO];
    [self redirectSTD:STDERR_FILENO];
    [[__xengine__module_dcloud shareInstance] application:application didFinishLaunchingWithOptions:launchOptions];

    [[XEngineContext sharedInstance] start];
    [[XEngineContext sharedInstance]  onApplicationDelegate:NSStringFromSelector(_cmd) arg1:application args:launchOptions];

     self.window.rootViewController = [[ZYDL_TabBarController alloc] init];
    
    
    return YES;
}

#pragma mark - App 生命周期方法
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[__xengine__module_dcloud shareInstance] applicationWillTerminate:application];
}
  
@end
