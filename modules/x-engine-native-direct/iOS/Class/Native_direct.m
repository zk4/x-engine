//
//  Native_direct.m
//  direct
//
//  Created by zk on 2020/9/7.


#import "Native_direct.h"
#import "XENativeContext.h"
#import "iDirectManager.h"
#import "iDirect.h"
#import "NSURL+QueryDictionary.h"
#import "HistoryModel.h"
#import "GlobalState.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "UIViewController+Tag.h"

@interface Native_direct()
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iDirect>> * directors;
@end

@implementation Native_direct
NATIVE_MODULE(Native_direct)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct";
}

- (int) order{
    return 0;
}

- (instancetype)init
{
    self = [super init];
    self.directors=[NSMutableDictionary new];
    return self;
}

- (void)afterAllNativeModuleInited{
   NSArray* modules= [[XENativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        [self.directors setObject:direct forKey:[direct scheme]];
    }
}

- (void) _back:(NSString*) host fragment:(NSString*) fragment{
    UINavigationController* navC=[Unity sharedInstance].getCurrentVC.navigationController;
    NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
//    NSMutableArray<HistoryModel*>*  histories= nil;

//    histories = [[GlobalState sharedInstance] getCurrentHostHistories];

    BOOL isMinusHistory = [fragment rangeOfString:@"^-\\d+$" options:NSRegularExpressionSearch].location != NSNotFound;
    BOOL isNamedHistory = [fragment rangeOfString:@"^/\\w+$" options:NSRegularExpressionSearch].location != NSNotFound;
    
    if ([@"0" isEqualToString:fragment]){
        [navC popToRootViewControllerAnimated:TRUE];
//        [histories removeAllObjects];
    } else if ([@"/" isEqualToString:fragment]){
        if(ary && ary.count > 0){
            [navC popToViewController:ary[0] animated:YES];
//            [histories removeObjectsInRange:NSMakeRange(1, histories.count - 1)];
        }
    } else if ([@"-1" isEqualToString:fragment] || [@"" isEqualToString:fragment]){
        if(ary){
            if(ary.count > 1) {
                [navC popToViewController:ary[ary.count-2] animated:YES];
//                [histories removeLastObject];
            } else if(ary.count ==1){
                [navC popViewControllerAnimated:YES];
//                [histories removeLastObject];
            }
        }
    } else if(isMinusHistory) {
        if(ary){
            int minusHistory = [fragment intValue];
            if(minusHistory+ary.count<0){
                /// TODO: alert
                NSLog(@"没有历史给你退.");
            }
            [navC popToViewController:ary[ary.count-1+minusHistory] animated:YES];
//            [histories removeObjectsInRange:NSMakeRange(histories.count+minusHistory,  -minusHistory)];
        }
    } else if (isNamedHistory){
        if(ary && ary.count > 1){
            int i = 0;
            for (UIViewController *vc in [ary reverseObjectEnumerator]){
                HistoryModel *hm = [vc getLastHistory];
                if(hm && [hm.fragment isEqualToString:fragment]){
                    [navC popToViewController:hm.vc animated:YES];
                    
//                    [ary removeObjectsInRange:NSMakeRange(ary.count -i,  i)];
                    return;
                }
                i++;
            }
        }
    } else {
        /// TODO: alert
        NSLog(@"what the fuck? %@",fragment);
    }
}

- (void)back: (NSString*) scheme host:(NSString*) host fragment:(NSString*) fragment{
    id<iDirect> direct = [self.directors objectForKey:scheme];
    // 如果不实现,委托给管理类实现
    if([direct respondsToSelector:@selector(back:host:fragment:)]){
        [direct back:host fragment:fragment];
    }else{
        [self _back:host fragment:fragment];
    }
}


- (nonnull UIViewController *)getContainer:(nonnull NSString *)scheme host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
    
    id<iDirect> direct = [self.directors objectForKey:scheme];
    UIViewController* container =[direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params];
    return container;
    
}

- (void)push: (NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(nullable NSDictionary<NSString*,NSString*>*) query
        params:(NSDictionary<NSString*,NSString*>*) params {
    
    id<iDirect> direct = [self.directors objectForKey:scheme];
    
    // 复用上一次的 host
    if(host){
        pathname = pathname && (pathname.length!=0) ? pathname : @"/";
    } else {
        HistoryModel* hm= [[Unity sharedInstance].getCurrentVC.navigationController.viewControllers.lastObject getLastHistory];
        host = hm.host;
        NSAssert(host!=nil, @"host 不可为 nil");
        pathname = hm.pathname && (hm.pathname.length!=0) ? hm.pathname : @"/";
    }
    
    // 拿容器
    // TODO: container 里做历史栈的记录,不太科学,我还没入栈呢.
    UIViewController* container =[direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params];
    NSAssert(container,@"why here, where is your container?");

    // 加载容器
    [direct push:container params:params];
    
    // 如果是在 tab 上,则不受 history 管理.
    // 不然会出现这种情况,如果4 个 tab 上全是微应用.
    // 则会有 4 个永远不会消失的 history.
    HistoryModel* hm = [HistoryModel new];
 
    hm.fragment      = fragment;
    hm.webview       = nil;
    hm.host          = host;
    hm.pathname      = pathname;
    hm.onTab         = NO;
    [container setCurrentHistory:hm];
    
  
     
}

- (void)addToTab: (UIViewController*) parent
        scheme:(NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(nullable NSString*) fragment
        query:(nullable NSDictionary<NSString*,id>*) query
          params:(nullable NSDictionary<NSString*,id>*) params{
    
    id<iDirect> direct = [self.directors objectForKey:scheme];
    // TODO: container 里做历史栈的记录,不太科学,我还没入栈呢.
    UIViewController* vc =  [direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params];
    [parent addChildViewController:vc];
    
    [parent.view addSubview:vc.view];
    vc.view.frame = parent.view.frame;
    
    // 如果是在 tab 上,则不受 history 管理.
    // 不然会出现这种情况,如果4 个 tab 上全是微应用.
    // 则会有 4 个永远不会消失的 history.
    HistoryModel* hm = [HistoryModel new];
 
    hm.fragment      = fragment;
    hm.webview       = nil;
    hm.host          = host;
    hm.pathname      = pathname;
    hm.onTab         = YES;
    [parent setCurrentHistory:hm];
    

}

static NSString *const kQueryBegin          = @"?";
static NSString *const kFragmentBegin       = @"#";
static NSString *const kSlash               = @"/";

- (NSString*)SPAUrl2StandardUrl:(NSString*)raw {
    int questionMark = -1;
    int hashtagMark = -1;

    for (int i=0;i< raw.length;i++){
        char cc= [raw characterAtIndex:i];

        if(cc == '#' && hashtagMark == -1){
            hashtagMark=i;
        }
        // 仅当找到 hashtag 后才再找?, 不然不是 SPA url
        if(hashtagMark != -1 && cc == '?' && questionMark == -1){
            questionMark=i;
        }
    }
    if(questionMark != -1 && hashtagMark != -1){
        NSString* sub1= [raw substringToIndex:hashtagMark];
        NSString* sub2= [raw substringWithRange:NSMakeRange(hashtagMark, questionMark-hashtagMark)];
        NSString* sub3=[ [raw substringFromIndex:questionMark]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [NSString stringWithFormat:@"%@%@%@",sub1,sub3,sub2] ;
    }
    return raw;
}


- (void)push:(nonnull NSString *)uri params:(nullable NSDictionary<NSString *,id> *)params{
    // convert SPA url hash router style to standard url style
    // TODO: 写这不合适. manager 理应不关心 port
    NSURL* url = [NSURL URLWithString:[self SPAUrl2StandardUrl:uri]];
    NSNumber* port = url.port;
    if(!port){
        if([url.scheme isEqualToString:@"https"])
            port = @443;
        else if([url.scheme isEqualToString:@"http"])
            port = @80;
        
    }
    NSString* host = [NSString stringWithFormat:@"%@%@%@",url.host,port?@":":@"",port?port:@""];

    [self push:url.scheme host:host pathname:url.path fragment:url.fragment query:url.uq_queryDictionary params:params];
}

- (void)addToTab:(nonnull UIViewController *)parent uri:(nonnull NSString *)uri params:(nullable NSDictionary<NSString *,id> *)params {
    // convert SPA url hash router style to standard url style
    // TODO: 写这不合适. manager 理应不关心 port
    NSURL* url = [NSURL URLWithString:[self SPAUrl2StandardUrl:uri]];
    NSNumber* port = url.port;
    if(!port){
        if([url.scheme isEqualToString:@"https"])
            port = @443;
        else if([url.scheme isEqualToString:@"http"])
            port = @80;
        
    }
    NSString* host = [NSString stringWithFormat:@"%@%@%@",url.host,port?@":":@"",port?port:@""];
    
 
    [self addToTab:parent scheme:url.scheme host:host pathname:url.path fragment:url.fragment query:url.uq_queryDictionary params:params];
    

}
 


@end
 
