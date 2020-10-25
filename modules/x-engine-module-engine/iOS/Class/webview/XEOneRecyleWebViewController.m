//
//  RecyleWebViewController.m

#import "XEOneRecyleWebViewController.h"
#import "XEOneWebViewPool.h"
#import "micros.h"
#import <WebKit/WebKit.h>
#import "XEngineWebView.h"
//#import "JSONToDictionary.h"
#import "xengine__module_BaseModule.h"

#import "Unity.h"
#import "ZKPushAnimation.h"

@interface XEOneRecyleWebViewController ()

@property (nonatomic, strong) CALayer *progresslayer;

@end

@implementation XEOneRecyleWebViewController

- (void)forwardUrl:(NSString *)preLevelPath{
    
    if (preLevelPath) {
        NSArray<WKBackForwardListItem *> *backList = self.webview.backForwardList.forwardList;
        for (NSInteger i = backList.count - 1; i >= 0; i--){
        WKBackForwardListItem *item = backList[i];
//        for (WKBackForwardListItem *item in backList){
            NSURLComponents *itemComponents = [NSURLComponents componentsWithURL:item.URL resolvingAgainstBaseURL:YES];
            NSString *itemPath = itemComponents.path;
            NSString *itemFragment = [self framentEmptyAction:itemComponents.fragment];
            
            
            NSURLComponents *finderComponents = [NSURLComponents componentsWithString:preLevelPath];
            NSString *finderPath = finderComponents.path;
            NSString *finderFragment = [self framentEmptyAction:finderComponents.fragment];

            if([itemPath isEqualToString:finderPath]
               && [itemFragment isEqualToString:finderFragment]){
                [self.webview goToBackForwardListItem:item];
                return;
            }
        }
    } else {
        [self.webview goBack];
    }
}

-(NSString *)framentEmptyAction:(NSString *)frament{
    NSString *flag;
    if( frament == nil || [frament isEqualToString:@"/"] || [frament isEqualToString:@"null"]){
        flag = @"";
    } else {
        flag = frament;
    }
    return flag;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

}

-(void)viewDidLoad{
    [super viewDidLoad];
}
@end
