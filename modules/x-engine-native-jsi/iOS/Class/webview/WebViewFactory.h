//
//  WebViewPool.h
//  x-engine-module-engine
//


#import <UIKit/UIKit.h>
#import "XEngineWebView.h"



@interface WebViewFactory: NSObject
@property (nonatomic, strong) NSPointerArray* webviews;
    + (instancetype)sharedInstance;
    -(XEngineWebView *)createWebView;

@end




