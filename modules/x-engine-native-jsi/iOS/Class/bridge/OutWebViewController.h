//
//  OutWebViewController.h
//  Appc
//
//  Created by 段冲冲 on 2022/6/16.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OutWebViewController : UIViewController

- (instancetype _Nonnull)initWithUrl:(NSString * _Nullable)fileUrl
                    withHiddenNavBar:(BOOL)isHidden webviewFrame:(CGRect) frame looseNetwork:(BOOL)isLooseNetwork;

- (WKWebView* _Nonnull) getWebView;

@end

NS_ASSUME_NONNULL_END
