//
//  Native_webcache.m
//  webcache
//


#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>
#import "Native_webcache.h"
#import "XENativeContext.h"
#import "SLWebCacheManager.h"



@interface Native_webcache()
@property (nonatomic, strong)     SLWebCacheManager *cacheManager;

@end

@implementation Native_webcache
NATIVE_MODULE(Native_webcache)

 - (NSString*) moduleId{
    return @"com.zkty.native.webcache";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    self.cacheManager =[SLWebCacheManager shareInstance];
} 
- (instancetype)init {
    self = [super init];
    if (self) {}
    
    return self;
}

 
- (void)enableXHRIntercept:(WKWebView*)webview {

    NSString *ajaxhookjs = [[NSBundle mainBundle] pathForResource:@"ajaxhook" ofType:@"js"];
    NSString *ajaxhookjs_content = [NSString stringWithContentsOfFile:ajaxhookjs encoding:NSUTF8StringEncoding error:nil];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:ajaxhookjs_content injectionTime:WKUserScriptInjectionTimeAtDocumentEnd  forMainFrameOnly:YES];
    [webview.configuration.userContentController addUserScript:script];

}

- (void)disableCache {
    self.cacheManager.isUsingURLProtocol = YES;
    [self.cacheManager closeCache];
}


- (void)enableCache {
    [self.cacheManager openCache];
}

- (void)clearCache {
    [self.cacheManager clearCache];
}

- (NSUInteger)cacheSize {
    return [self.cacheManager folderSize];
}

- (void)addWhiteHost:(NSString*)host;{
    [self.cacheManager addWhiteHost:host];
}

- (void)addBlackHost:(NSString*)host{
    [self.cacheManager addBlackHost:host];
}



@end
 
