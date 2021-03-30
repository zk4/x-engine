//
//  WebViewPool.h
//  x-engine-module-engine
//
//  Created by 吕冬剑 on 2020/9/18.
//

#import <UIKit/UIKit.h>
#import "XEngineWebView.h"
#import "XEOneWebViewPoolModel.h"


@interface XEOneWebViewPool: NSObject
@property (nonatomic, strong) NSMutableArray<XEOneWebViewPoolModel *>* webCacheAry;

    + (instancetype)sharedInstance;
    -(XEOneWebViewPoolModel *)createWebView:(NSString *)baseUrl;
    - (XEOneWebViewPoolModel *)getModelWithWeb:(WKWebView *)webView;

@end




