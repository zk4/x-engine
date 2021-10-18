//
//  XEngineWebView.m
//  BIG THX TO DSBRIDGE.
//  此代码大部分取自 DsBridge。
//  由于 DsBridge 在很多第三库里都有依赖。经常会报类冲突。遂改名。
//  源代码在 https://github.com/wendux/DSBridge-IOS


#import "XEngineWebView.h"
#import "XEngineJSBUtil.h"
#import "XEngineCallInfo.h"
#import "XEngineInternalApis.h"
#import <objc/message.h>
#import "XENativeContext.h"
#import "JSIModule.h"
#import "iToast.h"
#import "XTool.h"

#define BROADCAST_EVENT @"@@VUE_LIFECYCLE_EVENT"

typedef void (^XEngineCallBack)(id _Nullable result,BOOL complete);

@implementation XEngineWebView {
    void (^alertHandler)(void);
    void (^confirmHandler)(BOOL);
    void (^promptHandler)(NSString *);
    void(^javascriptCloseWindowListener)(void);
    int dialogType;
    int callId;
    bool jsDialogBlock;
    NSMutableDictionary<NSString *,id> *javaScriptNamespaceInterfaces;
    NSMutableDictionary *handerMap;
    NSMutableArray<XEngineCallInfo *> * callInfoList;
    NSDictionary<NSString*,NSString*> *dialogTextDic;
    UITextField *txtName;
    UInt64 lastCallTime ;
    NSString *jsCache;
    NSString *moduleId;
    bool isPending;
    bool isDebug;
    dispatch_semaphore_t semaphore_webloaded;
    UISwipeGestureRecognizer *swiperGesture;
}


-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration
{
    txtName=nil;
    dialogType=0;
    callId=0;
    alertHandler=nil;
    confirmHandler=nil;
    promptHandler=nil;
    jsDialogBlock=true;
    callInfoList=[NSMutableArray array];
    javaScriptNamespaceInterfaces=[NSMutableDictionary dictionary];
    handerMap=[NSMutableDictionary dictionary];
    lastCallTime = 0;
    jsCache=@"";
    isPending=false;
    isDebug=false;
    dialogTextDic=@{};
    semaphore_webloaded = dispatch_semaphore_create(0);
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:@"window._dswk=true;"
                                                  injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                               forMainFrameOnly:YES];
    [configuration.userContentController addUserScript:script];
    
    self = [super initWithFrame:frame configuration: configuration];
    if (self) {
        super.UIDelegate=self;
        super.navigationDelegate = self;
    }
    // add internal Javascript Object
    XEngineInternalApis *  interalApis= [[XEngineInternalApis alloc] init];
    interalApis.webview=self;
    [self addJavascriptObject:interalApis namespace:@"_dsb"];
    
    //    if (@available(iOS 13.0, *)) {
    //        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    //    } else {
    // Fallback on earlier versions
    /// TODO: 上面的函数只支持iOS 13.0,保持低版本兼容 @cwz
    //    }
    //    self.indicatorView.center = [UIApplication sharedApplication].keyWindow.rootViewController.view.center;
    //    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview: self.indicatorView];
    
    // 添加webview手势 如果recyleVc失效 就启用这个的
    self->swiperGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    self->swiperGesture.direction = UISwipeGestureRecognizerDirectionRight;
    self->swiperGesture.delegate = self;
    [self addGestureRecognizer:self->swiperGesture];
    return self;
}

// 一定要返回yes 让手势能往下传递
- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt
    defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    NSString * prefix=@"_dsbridge=";
    if ([prompt hasPrefix:prefix])
    {
        NSString *method= [prompt substringFromIndex:[prefix length]];
        NSString *result=nil;
        if(isDebug){
            result =[self call:method :defaultText ];
        }else{
            @try {
                result =[self call:method :defaultText ];
            }@catch(NSException *exception){
                NSLog(@"%@", exception);
            }
        }
        completionHandler(result);
        
    }else {
        if(!jsDialogBlock){
            completionHandler(nil);
        }
        if(self.DSUIDelegate && [self.DSUIDelegate respondsToSelector:
                                 @selector(webView:runJavaScriptTextInputPanelWithPrompt
                                           :defaultText:initiatedByFrame
                                           :completionHandler:)])
        {
            return [self.DSUIDelegate webView:webView runJavaScriptTextInputPanelWithPrompt:prompt
                                  defaultText:defaultText
                             initiatedByFrame:frame
                            completionHandler:completionHandler];
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:prompt
                                                                           message:@""
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:dialogTextDic[@"promptOkBtn"]?dialogTextDic[@"promptOkBtn"]:@"确定"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                if(completionHandler){
                    if(alert.textFields.count > 0){
                        completionHandler(alert.textFields.firstObject.text);
                        return;
                    }
                }
                completionHandler(@"");
            }];
            [alert addAction:action];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:dialogTextDic[@"promptCancelBtn"]?dialogTextDic[@"promptCancelBtn"]:@"取消"
                                                             style:UIAlertActionStyleDestructive
                                                           handler:nil];
            [alert addAction:cancel];
            [alert addTextFieldWithConfigurationHandler:nil];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(void))completionHandler
{
    [XENP(iToast) toastCurrentView:message duration:0.5f];
    //    if(!jsDialogBlock){
    completionHandler();
    //    }
    //    if( self.DSUIDelegate &&  [self.DSUIDelegate respondsToSelector:
    //                               @selector(webView:runJavaScriptAlertPanelWithMessage
    //                                         :initiatedByFrame:completionHandler:)])
    //    {
    //        return [self.DSUIDelegate webView:webView runJavaScriptAlertPanelWithMessage:message
    //                         initiatedByFrame:frame
    //                        completionHandler:completionHandler];
    //    }else{
    
    //        UIAlertController *alert = [UIAlertController alertControllerWithTitle:dialogTextDic[@"alertTitle"]?dialogTextDic[@"alertTitle"]:@"提示"
    //                                                                       message:message
    //                                                                preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction *action = [UIAlertAction actionWithTitle:dialogTextDic[@"alertBtn"]?dialogTextDic[@"alertBtn"]:@"确定"
    //                                                         style:UIAlertActionStyleDefault
    //                                                       handler:^(UIAlertAction * _Nonnull action) {
    //            if(completionHandler){
    //                completionHandler();
    //            }
    //        }];
    //        [alert addAction:action];
    //        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    //    }
}

-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    if(!jsDialogBlock){
        completionHandler(YES);
    }
    if( self.DSUIDelegate&& [self.DSUIDelegate respondsToSelector:
                             @selector(webView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:completionHandler:)])
    {
        return[self.DSUIDelegate webView:webView runJavaScriptConfirmPanelWithMessage:message
                        initiatedByFrame:frame
                       completionHandler:completionHandler];
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:dialogTextDic[@"confirmTitle"]?dialogTextDic[@"confirmTitle"]:@"提示"
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:dialogTextDic[@"confirmOkBtn"]?dialogTextDic[@"confirmOkBtn"]:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
            if(completionHandler){
                completionHandler(YES);
            }
        }];
        [alert addAction:action];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:dialogTextDic[@"confirmCancelBtn"]?dialogTextDic[@"confirmCancelBtn"]:@"取消"
                                                         style:UIAlertActionStyleDestructive
                                                       handler:nil];
        [alert addAction:cancel];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if( self.DSUIDelegate && [self.DSUIDelegate respondsToSelector:
                              @selector(webView:createWebViewWithConfiguration:forNavigationAction:windowFeatures:)]){
        return [self.DSUIDelegate webView:webView createWebViewWithConfiguration:configuration forNavigationAction:navigationAction windowFeatures:windowFeatures];
    }
    return  nil;
}

- (void)webViewDidClose:(WKWebView *)webView{
    if( self.DSUIDelegate && [self.DSUIDelegate respondsToSelector:
                              @selector(webViewDidClose:)]){
        [self.DSUIDelegate webViewDidClose:webView];
    }
}

- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo{
    if( self.DSUIDelegate
       && [self.DSUIDelegate respondsToSelector:
           @selector(webView:shouldPreviewElement:)]){
        return [self.DSUIDelegate webView:webView shouldPreviewElement:elementInfo];
    }
    return NO;
}

- (UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id<WKPreviewActionItem>> *)previewActions{
    if( self.DSUIDelegate &&
       [self.DSUIDelegate respondsToSelector:@selector(webView:previewingViewControllerForElement:defaultActions:)]){
        return [self.DSUIDelegate
                webView:webView
                previewingViewControllerForElement:elementInfo
                defaultActions:previewActions
                ];
    }
    return  nil;
}


- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController{
    if( self.DSUIDelegate
       && [self.DSUIDelegate respondsToSelector:@selector(webView:commitPreviewingViewController:)]){
        return [self.DSUIDelegate webView:webView commitPreviewingViewController:previewingViewController];
    }
}


- (void)showErrorAlert:(NSString *)message
{
    [XENP(iToast) toast:message duration:1.0];
    //    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@",message] preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    [errorAlert addAction:sureAction];
    //    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:errorAlert animated:YES completion:^{
    //
    //    }];
}

- (void) evalJavascript:(int) delay{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        @synchronized(self){
            if([self->jsCache length]!=0){
                [self evaluateJavaScript :self->jsCache completionHandler:nil];
                self->isPending=false;
                self->jsCache=@"";
                self->lastCallTime=[[NSDate date] timeIntervalSince1970]*1000;
            }
        }
    });
}
//字典转json格式字符串:
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



-(id) convertDict:(id) obj {
    SEL selector = NSSelectorFromString(@"toDictionary");
    if([obj respondsToSelector:selector]){
        id(*action)(id,SEL) = (id(*)(id,SEL))objc_msgSend;
        return   action(obj, selector);
    }else if ([obj isKindOfClass:NSDictionary.class]){
        return [XToolDataConverter dictionaryToJson:obj ];
    }else{
        return [NSString stringWithFormat:@"%@",obj];
    }
}

- (NSString *)call:(NSString*) method :(NSString*) argStr {
    NSArray *nameStr=[XEngineJSBUtil parseNamespace:[method stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    if(nameStr.count<2){
        NSLog(@"JS 参数有错,%@",nameStr);
        return nil;
    }
    NSString* moduleName = nameStr[0];
    NSString* methodName = nameStr[1];
    
    id JavascriptInterfaceObject = javaScriptNamespaceInterfaces[moduleName];
    NSString *error = [NSString stringWithFormat:@"Error! \n Method %@ is not invoked, since there is not a implementation for it",method];
    NSMutableDictionary*result = [NSMutableDictionary dictionaryWithDictionary:
                                  @{
                                      @"code":@-1,
                                      @"data":[NSNull null]
                                  }];
    if(!JavascriptInterfaceObject){
        //        [self showErrorAlert:[NSString stringWithFormat:@"Js bridge called, but can't find %@ 模块, please check your code!",modulename]];
        [self showErrorAlert:[NSString stringWithFormat:@"没有找到原生%@模块, 请联系原生开发人员", moduleName]];
        NSLog(@"Js bridge  called, but can't find a corresponded JavascriptObject , please check your code!");
    } else {
        NSString *methodOne = [XEngineJSBUtil methodByNameArg:1 selName:methodName class:[JavascriptInterfaceObject class]];
        NSString *methodTwo = [XEngineJSBUtil methodByNameArg:2 selName:methodName class:[JavascriptInterfaceObject class]];
        SEL sel=NSSelectorFromString(methodOne);
        SEL selasyn=NSSelectorFromString(methodTwo);
        NSDictionary * args=[XEngineJSBUtil jsonStringToObject:argStr];
        id arg=args[@"data"];
        if(arg==[NSNull null]){
            arg=nil;
        }
        NSString * cb;
        do{
            if(args && (cb= args[@"_dscbstub"])){
                if([JavascriptInterfaceObject respondsToSelector:selasyn]){
                    __weak typeof(self) weakSelf = self;
                    void (^completionHandler)(id,BOOL) = ^(id value,BOOL complete){
                        __strong typeof(self) strongSelf = weakSelf;
                        
                        NSString *del=@"";
                        result[@"code"]=@0;
                        if(value!=nil){
                            result[@"data"]=[strongSelf convertDict:value];
                        }
                        value = [XEngineJSBUtil objToJsonString:result];
                        value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                        if(complete) {
                            del=[@"delete window." stringByAppendingString:cb];
                        }
                        NSString *js = [NSString stringWithFormat:@"try {%@(JSON.parse(decodeURIComponent(\"%@\")).data);%@; } catch(e){};",cb,(value == nil) ? @"" : value,del];
                        @synchronized(self) {
                            UInt64  t=[[NSDate date] timeIntervalSince1970]*1000;
                            strongSelf->jsCache=[strongSelf->jsCache stringByAppendingString:js];
                            if(t-strongSelf->lastCallTime<50){
                                if(!strongSelf->isPending){
                                    [strongSelf evalJavascript:50];
                                    strongSelf->isPending=true;
                                }
                            }else{
                                [strongSelf evalJavascript:0];
                            }
                        }
                    };
                    
                    void(*action)(id,SEL,id,id) = (void(*)(id,SEL,id,id))objc_msgSend;
                    JSIModule* jsi = (JSIModule*) JavascriptInterfaceObject;
                    [jsi lockCurrentWebView:self];
                    action(JavascriptInterfaceObject, selasyn, arg, completionHandler);
                    [jsi unlockCurrentWebView:self];
                    
                    break;
                }
            }else if([JavascriptInterfaceObject respondsToSelector:sel]){
                id ret;
                id(*action)(id,SEL,id) = (id(*)(id,SEL,id))objc_msgSend;
                
                JSIModule* jsi = (JSIModule*) JavascriptInterfaceObject;
                [jsi lockCurrentWebView:self];
                ret=action(JavascriptInterfaceObject,sel,arg);
                [jsi unlockCurrentWebView:self];
                [result setValue:@0 forKey:@"code"];
                if(ret!=nil){
                    [result setValue:[self convertDict:ret] forKey:@"data"];
                }
                
                break;
            }
            NSString *js = [error stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            if(isDebug){
                js = [NSString stringWithFormat:@"window.alert(decodeURIComponent(\"%@\"));",js];
                [self evaluateJavaScript :js completionHandler:nil];
            }
            NSLog(@"%@",error);
            [self showErrorAlert:error];
        }while (0);
    }
    return [XEngineJSBUtil objToJsonString:result];
}

- (void)setJavascriptCloseWindowListener:(void (^)(void))callback
{
    javascriptCloseWindowListener=callback;
}

- (void)setDebugMode:(bool)debug{
    isDebug=debug;
}
-(void) _loadRequest:(NSURLRequest*) req{
    NSURL * url = req.URL;
    if(!self.model){
        self.model = [HistoryModel new];
    }
    self.model.host= url.host;
    self.model.fragment=url.fragment;
    self.model.pathname=url.path;
    [self loadRequest:req];
    
}

- (void) _loadFileURL:(NSURL*)fileURL allowingReadAccessToURL:(NSURL*) accessURL{
    if(!self.model){
        self.model = [HistoryModel new];
    }
    self.model.host= fileURL.host;
    self.model.fragment=fileURL.fragment;
    self.model.pathname=fileURL.path;
    [self loadFileURL:fileURL allowingReadAccessToURL:accessURL];
}
- (void)loadUrl: (NSString *)url
{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURL* nsurl = [NSURL URLWithString:url];
    if(!self.model){
        self.model = [HistoryModel new];
    }
    self.model.host= nsurl.host;
    self.model.fragment=nsurl.fragment;
    self.model.pathname=nsurl.path;
    [self loadRequest:request];
}


- (void)callHandler:(NSString *)methodName arguments:(id)args{
    [self callHandler:methodName arguments:args completionHandler:nil];
}

- (void)callHandler:(NSString *)methodName completionHandler:(void (^)(id _Nullable))completionHandler{
    [self callHandler:methodName arguments:nil completionHandler:completionHandler];
}

-(void)callHandler:(NSString *)methodName arguments:(id)args completionHandler:(void (^)(id  _Nullable value))completionHandler
{
    XEngineCallInfo *callInfo=[[XEngineCallInfo alloc] init];
    callInfo.id=[NSNumber numberWithInt: callId++];
    callInfo.args=args==nil?@[]:@[args];
    callInfo.method=methodName;
    if(completionHandler){
        [handerMap setObject:completionHandler forKey:callInfo.id];
    }
    if(callInfoList!=nil){
        [callInfoList addObject:callInfo];
    }else{
        [self dispatchJavascriptCall:callInfo];
    }
}

- (void)dispatchStartupQueue{
    if(callInfoList==nil) return;
    for (XEngineCallInfo * callInfo in callInfoList) {
        [self dispatchJavascriptCall:callInfo];
    }
    callInfoList=nil;
}

- (void) dispatchJavascriptCall:(XEngineCallInfo*) info{
    NSString * json=[XEngineJSBUtil objToJsonString:@{@"method":info.method,@"callbackId":info.id,
                                                      @"data":[XEngineJSBUtil objToJsonString: info.args]}];
    
    __weak typeof(self) weakSelf = self;
    // TODO: FIXME: 要这么复杂？ 想要实现的功能，
    // 等待 webviewload 完再，再evaljavascript。 但 evaljavascript 看上去要在主线程里执行才行。
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        __strong typeof(self) strongSelf = weakSelf;
        dispatch_semaphore_wait(strongSelf->semaphore_webloaded, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf evaluateJavaScript:[NSString stringWithFormat:@"window._handleMessageFromNative(%@)",json]
                       completionHandler:nil];
            });
        dispatch_semaphore_signal(strongSelf->semaphore_webloaded);
    });
    
}

- (void) addJavascriptObject:(id)object namespace:(NSString *)namespace{
    if(namespace==nil){
        namespace=@"";
    }
    if(object!=NULL){
        [javaScriptNamespaceInterfaces setObject:object forKey:namespace];
    }
}

- (void) removeJavascriptObject:(NSString *)namespace {
    if(namespace==nil){
        namespace=@"";
    }
    [javaScriptNamespaceInterfaces removeObjectForKey:namespace];
}

- (void)customJavascriptDialogLabelTitles:(NSDictionary *)dic{
    if(dic){
        dialogTextDic=dic;
    }
}

- (id)onMessage:(NSDictionary *)msg type:(int)type{
    id ret=nil;
    switch (type) {
        case XEngine_DSB_API_HASNATIVEMETHOD:
            ret= [self hasNativeMethod:msg]?@1:@0;
            break;
        case XEngine_DSB_API_CLOSEPAGE:
            [self closePage:msg];
            break;
        case XEngine_DSB_API_RETURNVALUE:
            ret=[self returnValue:msg];
            break;
        case XEngine_DSB_API_DSINIT:
            ret=[self dsinit:msg];
            break;
        case XEngine_DSB_API_DISABLESAFETYALERTBOX:
            [self disableJavascriptDialogBlock:[msg[@"disable"] boolValue]];
            break;
        default:
            break;
    }
    return ret;
}

- (bool) hasNativeMethod:(NSDictionary *) args
{
    NSArray *nameStr=[XEngineJSBUtil parseNamespace:[args[@"name"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    NSString * type= [args[@"type"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    id JavascriptInterfaceObject= [javaScriptNamespaceInterfaces objectForKey:nameStr[0]];
    if(JavascriptInterfaceObject){
        bool syn=[XEngineJSBUtil methodByNameArg:1 selName:nameStr[1] class:[JavascriptInterfaceObject class]]!=nil;
        bool asyn=[XEngineJSBUtil methodByNameArg:2 selName:nameStr[1] class:[JavascriptInterfaceObject class]]!=nil;
        if(([@"all" isEqualToString:type]&&(syn||asyn))
           ||([@"asyn" isEqualToString:type]&&asyn)
           ||([@"syn" isEqualToString:type]&&syn)
           ){
            return true;
        }
    }
    return false;
}

- (id) closePage:(NSDictionary *) args{
    if(javascriptCloseWindowListener){
        javascriptCloseWindowListener();
    }
    return nil;
}

- (id) returnValue:(NSDictionary *) args{
    void (^ completionHandler)(NSString *  _Nullable)= handerMap[args[@"id"]];
    if(completionHandler){
        if(isDebug){
            completionHandler(args[@"data"]);
        }else{
            @try{
                completionHandler(args[@"data"]);
            }@catch (NSException *e){
                NSLog(@"%@",e);
            }
        }
        if([args[@"complete"] boolValue]){
            [handerMap removeObjectForKey:args[@"id"]];
        }
    }
    return nil;
}

- (id) dsinit:(NSDictionary *) args{
    [self dispatchStartupQueue];
    return nil;
}

- (void) disableJavascriptDialogBlock:(bool) disable{
    jsDialogBlock=!disable;
}

- (void)hasJavascriptMethod:(NSString *)handlerName methodExistCallback:(void (^)(bool exist))callback{
    [self callHandler:@"_hasJavascriptMethod" arguments:@[handlerName] completionHandler:^(NSNumber* _Nullable value) {
        callback([value boolValue]);
    }];
}

// CAUTION: 要保证 webview 先触发才可能触发其他生命周期，不然没有意义，有可能页面还没加载未完成
- (void)triggerVueLifeCycleWithMethod:(NSString *)method {
    [self callHandler:@"com.zkty.jsi.engine.lifecycle.notify" arguments:@{
        @"type":method,
        @"payload":[NSString stringWithFormat:@"%p:%@",self,method]
    }
    completionHandler:^(id  _Nullable value) {}];
 
}

#pragma mark - <WKWebView cycleLife>
// 1.1- 询问开发者是否下载并载入当前 URL
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString * urlStr = [navigationAction.request.URL absoluteString];
    NSRange range = NSMakeRange(0, 0);
    NSURL * URL;
    NSString *scheme;
    
    if ([urlStr hasPrefix:@"weixin://"] || [urlStr hasPrefix:@"alipay://"]  || [urlStr hasPrefix:@"alipays://"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    if ([urlStr rangeOfString:@"?"].location !=NSNotFound) {
        range = [urlStr rangeOfString:@"?"];//匹配得到的下标
        URL = [NSURL URLWithString:[urlStr substringToIndex:range.location]];
        scheme = [URL scheme];
        //        subUrlStr = [URL absoluteString];
    } else {
        URL = [NSURL URLWithString:urlStr];
        scheme = [URL scheme];
        //        subUrlStr = [URL absoluteString];
    }
    if ([scheme isEqualToString:@"x-engine-json"] || [scheme isEqualToString:@"x-engine-call"]){
        NSString * argsStr ;
        if ([urlStr rangeOfString:@"?"].location !=NSNotFound) {
            argsStr = [urlStr substringFromIndex:range.location+1];
        }else{
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        NSString * callBackStr = @"";
        
        NSDictionary * argsDic;// = [NSDictionary new];
        
        if ([argsStr rangeOfString:@"&"].location !=NSNotFound){
            NSArray * array = [argsStr componentsSeparatedByString:@"&"];
            argsStr = [NSString stringWithFormat:@"%@",array[0]];
            callBackStr = [NSString stringWithFormat:@"%@",array[1]];
        }
        argsDic = [self jsonToDictionary:argsStr];
        if ([callBackStr rangeOfString:@"="].location !=NSNotFound){
            NSRange range = [callBackStr rangeOfString:@"="];//匹配得到的下标
            callBackStr= [callBackStr substringFromIndex:range.location+1];
        }
        
        id module;
        if ([scheme isEqualToString:@"x-engine-call"]) {
            NSString* moduleId = [NSString stringWithFormat:@"%@",URL.host];
            module =[[XENativeContext sharedInstance] getModuleById:moduleId];
        }else{
            module =[[XENativeContext sharedInstance] getModuleById:URL.host];
        }
        
        NSString * selectorStr = [NSString stringWithFormat:@"%@:complete:",[URL.path substringFromIndex:1]];
        SEL  sel = NSSelectorFromString(selectorStr);
        __weak typeof(self)weakSelf = self;
        if([module respondsToSelector:sel]){
            XEngineCallBack  Cb=  ^(id data, BOOL ret){
                if (callBackStr && callBackStr.length !=0) {
                    NSString * retDataStr = [self idFromObject:data];
                    
                    
                    NSString * str = [callBackStr stringByRemovingPercentEncoding];
                    str = [str stringByReplacingOccurrencesOfString:@"{ret}" withString:retDataStr];
                    str = [str stringByRemovingPercentEncoding];
                    str=[str stringByReplacingOccurrencesOfString:@"%23" withString:@"#"];
                    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
                    [weakSelf loadRequest:request];
                    
                }
            };
            
            
            [module performSelector:sel withObject:argsDic withObject:Cb];
            
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    if(self.DSNavigationDelegate && [self.DSNavigationDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [self.DSNavigationDelegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
// 2.1- 开始下载指定 URL 的内容, 下载之前会调用一次 开始下载 回调
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //    [self.indicatorView startAnimating];
    if(self.DSNavigationDelegate && [self.DSNavigationDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]){
        [self.DSNavigationDelegate webView:webView didStartProvisionalNavigation:navigation];
    }
}

// 2.2- 开始下载指定 URL 的内容, 下载之前会调用一次 开始下载 回调
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{ }


// 3- 确定下载的内容被允许之后再载入视图。
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    dispatch_semaphore_signal(semaphore_webloaded);
    [self triggerVueLifeCycleWithMethod:@"onWebviewShow"];
    if(self.DSNavigationDelegate && [self.DSNavigationDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]){
        [self.DSNavigationDelegate webView:webView didFinishNavigation:navigation];
    }
    [self removeGestureRecognizer:swiperGesture];
}

// 4.1- 成功则调用成功回调，整个流程有错误发生都会发出错误回调。
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //    [self.indicatorView stopAnimating];
    [self addCustomView];
}

// 4.2- 成功则调用成功回调，整个流程有错误发生都会发出错误回调。
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    //    [self.indicatorView stopAnimating];
    [self addCustomView];
}

//runtime model转字典转字符串
- (NSString *)idFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if (value == nil) {
            //null
            [dic setObject:@"" forKey:name];
            
        } else {
            //model
            [dic setObject:value forKey:name];
        }
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}

- (NSDictionary *)jsonToDictionary:(NSString * )jsonStr{
    if ([jsonStr rangeOfString:@"="].location !=NSNotFound){
        NSRange range = [jsonStr rangeOfString:@"="];//匹配得到的下标
        jsonStr= [jsonStr substringFromIndex:range.location+1];
    }
    
    jsonStr = [jsonStr stringByRemovingPercentEncoding];
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError*err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    return dic;
}

- (void)dealloc {
    //    [self.indicatorView stopAnimating];
    NSLog(@"dealloc webview");
}

// 如果WKWebView失效的话, 在WKWebView代理方法didFailProvisionalNavigation中
// 添加自定义的view 在view上添加侧滑手势,返回上个页面
- (void)addCustomView {
    UIView *view = [[UIView alloc] init];
    view.frame = self.frame;
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2 - 150, [UIScreen mainScreen].bounds.size.width, 200)];
    img.image = [UIImage imageNamed:@"404"];
    [view addSubview:img];
    
    
    UILabel *label = [[UILabel alloc] init];
    if (img.image) {
        label.frame = CGRectMake(0, CGRectGetMaxY(img.frame) + 10, [UIScreen mainScreen].bounds.size.width, 16);
    } else {
        label.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2 , [UIScreen mainScreen].bounds.size.width, 16);
    }
    label.text = @"您访问的页面找不到了";
    label.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    [self addSubview:view];
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan {
    [[self viewController].navigationController popViewControllerAnimated:YES];
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


@end
