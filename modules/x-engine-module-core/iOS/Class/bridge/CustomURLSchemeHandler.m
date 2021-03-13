//
//  CustomURLSchemeHandler.m
//  testWebview
//
//  Created by 杨方阔 on 2019/12/9.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "CustomURLSchemeHandler.h"
#import <WebKit/WebKit.h>
#import "AFHTTPSessionManager.h"
#import "AFURLSessionManager.h"
#import <MicroAppLoader.h>
#import "webviewModel.h"
static AFHTTPSessionManager *manager ;

@implementation CustomURLSchemeHandler

//这里拦截到URLScheme为customScheme的请求后，根据自己的需求,返回结果，并返回给WKWebView显示
- (void)webView:(WKWebView *)webView startURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask API_AVAILABLE(ios(11.0)){
    NSURLRequest *request = urlSchemeTask.request ;
    NSLog(@"request = %@",request);
    NSArray * arr = [MicroAppLoader sharedInstance].netmodel.white_host_list;
    //如果是我们替对方去处理请求的时候
    if (!manager) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
        //这个acceptableContentTypes类型自己补充,demo不写太多
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain", @"text/html", nil];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    if (![arr containsObject:request.URL.host]) {
        
        NSURLSessionDataTask * task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {

        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {

        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [urlSchemeTask didReceiveResponse:response];
            [urlSchemeTask didReceiveData:responseObject];
            [urlSchemeTask didFinish];
        }];
        [task resume];
    }else{
        
        NSURLSessionDataTask * task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        }];
        [task cancel];
        
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"" message:@"host 不在白名单内" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [errorAlert addAction:sureAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:errorAlert animated:YES completion:^{
            
        }];

    }
}

- (void)webView:(WKWebView *)webVie stopURLSchemeTask:(id)urlSchemeTask {
    NSLog(@"stop = %@",urlSchemeTask);
}


@end
