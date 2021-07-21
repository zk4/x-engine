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
{ }
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
    SLWebCacheManager *cacheManager = [SLWebCacheManager shareInstance];
    cacheManager.isUsingURLProtocol = YES;
    [cacheManager closeCache];
}


- (void)enableCache {
    SLWebCacheManager *cacheManager = [SLWebCacheManager shareInstance];
    [cacheManager openCache];
}


@end
 
