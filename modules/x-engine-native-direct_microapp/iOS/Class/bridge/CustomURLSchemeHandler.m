//
//  CustomURLSchemeHandler.m
//  testWebview
//
//  Created by 杨方阔 on 2019/12/9.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "CustomURLSchemeHandler.h"
#import <WebKit/WebKit.h>
#import "XEOneWebViewPool.h"
static NSString const*SchemeKey = @"SchemeKey";
static NSString const*TaskKey = @"TaskKey";
API_AVAILABLE(ios(11.0))
@interface CustomURLSchemeHandler ()
@property (nonatomic, strong) NSMutableDictionary<NSURL *, NSDictionary<NSString *, id> *> *dic;
@end

@implementation CustomURLSchemeHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dic = [@{} mutableCopy];
    }
    return self;
}
- (void)webView:(WKWebView *)webView startURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask API_AVAILABLE(ios(11.0)){
//    NSURLRequest *request = urlSchemeTask.request;
//    XEOneWebViewPoolModel *model = [[XEOneWebViewPool sharedInstance] getModelWithWeb:webView];
//    if(![model checkHavStr:request.URL.absoluteString withInAry:model.whiteList]){
//        
//        __weak typeof(self)weakSelf = self;
//        NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            __strong CustomURLSchemeHandler *strongSelf = weakSelf;
//            if(strongSelf){
//                id <WKURLSchemeTask> delegate;
//                NSDictionary *dic;
//                @synchronized (self) {
//                    dic = strongSelf.dic[request.URL];
//                }
//                delegate = dic[SchemeKey];
//                if(error){
//                    [delegate didFailWithError:error];
//                }else{
//                    [delegate didReceiveResponse:response];
//                    [delegate didReceiveData:data];
//                    [delegate didFinish];
//                }
//                strongSelf.dic[request.URL] = nil;
//            }
//        }];
//        self.dic[request.URL] = @{
//            SchemeKey:urlSchemeTask,
//            TaskKey:task,
//        };
//        [task resume];
//    }else{
//        
//        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@不在白名单内",request.URL.host] preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//        [errorAlert addAction:sureAction];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:errorAlert animated:YES completion:nil];
//        [urlSchemeTask didFailWithError:[[NSError alloc] init]];
//    }
}

- (void)webView:(WKWebView *)webVie stopURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask API_AVAILABLE(ios(11.0)) {
    @synchronized (self) {
        NSDictionary *dic = self.dic[urlSchemeTask.request.URL];
        self.dic[urlSchemeTask.request.URL] = nil;
        NSURLSessionDataTask *task = dic[TaskKey];
        [task cancel];
    }
}

@end
