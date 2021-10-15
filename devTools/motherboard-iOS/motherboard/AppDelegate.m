//
//  AppDelegate.m
//  iOS
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import <x-engine-native-core/XENativeContext.h>
#import "JSIContext.h"

#import "ZYDL_TabBarController.h"
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
    if(isatty(STDOUT_FILENO)) {
        return;
    }
  NSPipe * pipe = [NSPipe pipe] ;
  NSFileHandle *pipeReadHandle = [pipe fileHandleForReading] ;
  dup2([[pipe fileHandleForWriting] fileDescriptor], fd) ;
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(redirectNotificationHandle:)
                                               name:NSFileHandleReadCompletionNotification
                                             object:pipeReadHandle] ;
  [pipeReadHandle readInBackgroundAndNotify];
}
 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self redirectSTD:STDOUT_FILENO];
    [self redirectSTD:STDERR_FILENO];
 
    [[XENativeContext sharedInstance] start];
    self.window.rootViewController = [[ZYDL_TabBarController alloc] init];
    
    
    return YES;
}
 
@end
