#import "CustomURLSchemeHandler.h"
#import <WebKit/WebKit.h>
#import "WebViewFactory.h"
#import "NativeContext.h"
#import "iSecurify.h"

static NSString const*SchemeKey = @"SchemeKey";
static NSString const*TaskKey = @"TaskKey";
API_AVAILABLE(ios(11.0))
@interface CustomURLSchemeHandler ()
@property (nonatomic, strong) NSMutableDictionary<NSURL *, NSDictionary<NSString *, id> *> *dic;
@end

@implementation CustomURLSchemeHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dic = [@{} mutableCopy];
    }
    return self;
}
- (void)webView:(WKWebView *)webView startURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask API_AVAILABLE(ios(11.0)){
    
    // 判断有没有白名单
    id<iSecurify> securify = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iSecurify)];
    BOOL isAvailable = [securify judgeNetworkIsAvailableWithHostName:urlSchemeTask.request.URL.host];
    if (!isAvailable) {
        NSString *msg = [NSString stringWithFormat:@"%@不在白名单内", urlSchemeTask.request.URL.host];
        [self promptWithMessage:msg];
    } else {
        __weak typeof(self)weakSelf = self;
        NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:urlSchemeTask.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            __strong CustomURLSchemeHandler *strongSelf = weakSelf;
            if(strongSelf){
                id <WKURLSchemeTask> delegate;
                NSDictionary *dic;
                @synchronized (self) {
                    dic = strongSelf.dic[urlSchemeTask.request.URL];
                }
                delegate = dic[SchemeKey];
                if(error){
                    [delegate didFailWithError:error];
                }else{
                    [delegate didReceiveResponse:response];
                    [delegate didReceiveData:data];
                    [delegate didFinish];
                }
                strongSelf.dic[urlSchemeTask.request] = nil;
            }
        }];
        self.dic[urlSchemeTask.request.URL] = @{
            SchemeKey:urlSchemeTask,
            TaskKey:task,
        };
        [task resume];
    }
}

- (void)webView:(WKWebView *)webVie stopURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask API_AVAILABLE(ios(11.0)) {
    @synchronized (self) {
        NSDictionary *dic = self.dic[urlSchemeTask.request.URL];
        self.dic[urlSchemeTask.request.URL] = nil;
        NSURLSessionDataTask *task = dic[TaskKey];
        [task cancel];
    }
}

/// 提示
/// @param message 提示内容
- (void)promptWithMessage:(NSString *)message  {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController popViewControllerAnimated:YES];
    }];
    [errorAlert addAction:sureAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:errorAlert animated:YES completion:^{}];
}

@end
