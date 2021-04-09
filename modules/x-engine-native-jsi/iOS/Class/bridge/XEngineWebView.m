//
//  XEngineWebView.m



#import "XEngineWebView.h"
#import "XEngineJSBUtil.h"
#import "XEngineCallInfo.h"
#import "XEngineInternalApis.h"
#import <objc/message.h>
#import "NativeContext.h"
#import "GlobalState.h"
#import "iSecurify.h"
//#import "NSString+Extras.h"
typedef void (^XEngineCallBack)(id _Nullable result,BOOL complete);

@implementation XEngineWebView

{
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
    bool isPending;
    bool isDebug;
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
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.indicatorView.center = [UIApplication sharedApplication].keyWindow.rootViewController.view.center;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview: self.indicatorView];
    return self;
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
    if(!jsDialogBlock){
        completionHandler();
    }
    if( self.DSUIDelegate &&  [self.DSUIDelegate respondsToSelector:
                               @selector(webView:runJavaScriptAlertPanelWithMessage
                                         :initiatedByFrame:completionHandler:)])
    {
        return [self.DSUIDelegate webView:webView runJavaScriptAlertPanelWithMessage:message
                         initiatedByFrame:frame
                        completionHandler:completionHandler];
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:dialogTextDic[@"alertTitle"]?dialogTextDic[@"alertTitle"]:@"提示"
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:dialogTextDic[@"alertBtn"]?dialogTextDic[@"alertBtn"]:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
            if(completionHandler){
                completionHandler();
            }
        }];
        [alert addAction:action];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
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
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@",message] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [errorAlert addAction:sureAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:errorAlert animated:YES completion:^{
        
    }];
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

-(id) convertDict:(id) obj {
    SEL selector = NSSelectorFromString(@"toDictionary");
    if([obj respondsToSelector:selector]){
        id(*action)(id,SEL) = (id(*)(id,SEL))objc_msgSend;
        return   action(obj, selector);
    }else {
        return [NSString stringWithFormat:@"%@",obj ];
    }
}

- (NSString *)call:(NSString*) method :(NSString*) argStr {
    NSArray *nameStr=[XEngineJSBUtil parseNamespace:[method stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
//    id<iSecurify> securify = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iSecurify)];
//    BOOL isAvailable = [securify judgeModuleIsAvailableWithModuleName:nameStr[0]];
//    if (!isAvailable) {
//        return nil;
//    }
    
    id JavascriptInterfaceObject = javaScriptNamespaceInterfaces[nameStr[0]];
    NSString *error=[NSString stringWithFormat:@"Error! \n Method %@ is not invoked, since there is not a implementation for it",method];
    NSMutableDictionary*result =[NSMutableDictionary dictionaryWithDictionary:@{@"code":@-1,@"data":@""}];
    if(!JavascriptInterfaceObject){
        [self showErrorAlert:[NSString stringWithFormat:@"Js bridge  called, but can't find %@ 模块, please check your code!",nameStr[0]]];
        NSLog(@"Js bridge  called, but can't find a corresponded JavascriptObject , please check your code!");
    }else{
        method=nameStr[1];
        NSString *methodOne = [XEngineJSBUtil methodByNameArg:1 selName:method class:[JavascriptInterfaceObject class]];
        NSString *methodTwo = [XEngineJSBUtil methodByNameArg:2 selName:method class:[JavascriptInterfaceObject class]];
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
                        NSString *del=@"";
                        result[@"code"]=@0;
                        if(value!=nil){
                            result[@"data"]=[self convertDict:value];
                        }
                        
                        value=[XEngineJSBUtil objToJsonString:result];
                        value =[value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                        
                        if(complete){
                            del=[@"delete window." stringByAppendingString:cb];
                        }
                        NSString*js=[NSString stringWithFormat:@"try {%@(JSON.parse(decodeURIComponent(\"%@\")).data);%@; } catch(e){};",cb,(value == nil) ? @"" : value,del];
                        __strong typeof(self) strongSelf = weakSelf;
                        @synchronized(self)
                        {
                            UInt64  t=[[NSDate date] timeIntervalSince1970]*1000;
                            self->jsCache=[self->jsCache stringByAppendingString:js];
                            if(t-self->lastCallTime<50){
                                if(!self->isPending){
                                    [strongSelf evalJavascript:50];
                                    self->isPending=true;
                                }
                            }else{
                                [strongSelf evalJavascript:0];
                            }
                        }
                        
                    };
                    
                    void(*action)(id,SEL,id,id) = (void(*)(id,SEL,id,id))objc_msgSend;
                    [GlobalState setCurrentWebView:self];
                    action(JavascriptInterfaceObject, selasyn, arg, completionHandler);
                    break;
                }
            }else if([JavascriptInterfaceObject respondsToSelector:sel]){
                id ret;
                id(*action)(id,SEL,id) = (id(*)(id,SEL,id))objc_msgSend;
                ret=action(JavascriptInterfaceObject,sel,arg);
                [result setValue:@0 forKey:@"code"];
                if(ret!=nil){
                    [result setValue:ret forKey:@"data"];
                }
                break;
            }
            
            NSString*js = [error stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            if(isDebug){
                js=[NSString stringWithFormat:@"window.alert(decodeURIComponent(\"%@\"));",js];
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

- (void)loadUrl: (NSString *)url
{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
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
    [self evaluateJavaScript:[NSString stringWithFormat:@"window._handleMessageFromNative(%@)",json]
           completionHandler:nil];
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


#pragma mark - <WKWebView cycleLife>
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.indicatorView startAnimating];
    if(self.DSNavigationDelegate && [self.DSNavigationDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]){
        [self.DSNavigationDelegate webView:webView didStartProvisionalNavigation:navigation];
    }
}

// 页面加载完成后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [self.indicatorView stopAnimating];
    if(self.DSNavigationDelegate && [self.DSNavigationDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]){
        [self.DSNavigationDelegate webView:webView didFinishNavigation:navigation];
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"内容开始返回:%s",__FUNCTION__);
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.indicatorView stopAnimating];
    NSLog(@"%@",error.debugDescription);
}

- (NSDictionary *)jsonToDictionary:(NSString * )jsonStr{
    if ([jsonStr rangeOfString:@"="].location !=NSNotFound){
        NSRange range = [jsonStr rangeOfString:@"="];//匹配得到的下标
        jsonStr= [jsonStr substringFromIndex:range.location+1];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    jsonStr = [jsonStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError*err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    return dic;
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{}

// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
//    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
//}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString * urlStr = [navigationAction.request.URL absoluteString];
    NSRange range = NSMakeRange(0, 0);
    NSURL * URL;
    NSString *scheme;
//    NSString * subUrlStr;
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
            module =[[NativeContext sharedInstance] getModuleById:moduleId];
        }else{
            module =[[NativeContext sharedInstance] getModuleById:URL.host];
        }
        
        NSString * selectorStr = [NSString stringWithFormat:@"%@:complete:",[URL.path substringFromIndex:1]];
        SEL  sel = NSSelectorFromString(selectorStr);
        __weak typeof(self)weakSelf = self;
        if([module respondsToSelector:sel]){
            XEngineCallBack  Cb=  ^(id data, BOOL ret){
                if (callBackStr && callBackStr.length !=0) {
                    NSString * retDataStr = [self idFromObject:data];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    NSString * str = [callBackStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    str = [str stringByReplacingOccurrencesOfString:@"{ret}" withString:retDataStr];
                    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    str=[str stringByReplacingOccurrencesOfString:@"%23" withString:@"#"];
                    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
                    [weakSelf loadRequest:request];
#pragma clang diagnostic pop
                }
            };
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [module performSelector:sel withObject:argsDic withObject:Cb];
#pragma clang diagnostic pop
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
@end
