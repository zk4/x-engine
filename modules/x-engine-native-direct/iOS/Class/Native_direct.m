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
#import "Unity.h"
#import "UIViewController+Tag.h"
#import "iToast.h"
#import "XTool.h"

@interface Native_direct()
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iDirect>> * directors;
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSString*> * fallbackMappings;
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSString*> * forceMappings;

// 为了降低路由频率，用到的时间戳
@property (nonatomic,assign ) UInt64 lastTimeStamp;

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
    self.fallbackMappings = [NSMutableDictionary new];
    self.forceMappings = [NSMutableDictionary new];
    return self;
}

- (void)afterAllNativeModuleInited{
   NSArray* modules= [[XENativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        [self.directors setObject:direct forKey:[direct scheme]];
    }
   self.lastTimeStamp  = [[ NSDate date ] timeIntervalSince1970 ] * 1000;
}

- (void) _back:(NSString*) host fragment:(NSString*) fragment{
    UINavigationController* navC=[Unity sharedInstance].getCurrentVC.navigationController;

    // 是 present　出来的,不关注历史
    if(!navC){
        UIViewController* vc = [Unity sharedInstance].getCurrentVC;
        [vc dismissViewControllerAnimated:TRUE completion:^{
        }];
        return;
    }
    
    NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
 
 
    BOOL isMinusHistory = [fragment rangeOfString:@"^-\\d+$" options:NSRegularExpressionSearch].location != NSNotFound;
    BOOL isNamedHistory = [fragment rangeOfString:@"^/\\w+$" options:NSRegularExpressionSearch].location != NSNotFound;
    
    if ([@"0" isEqualToString:fragment]){
        [navC popToRootViewControllerAnimated:TRUE];

    } else if ([@"/" isEqualToString:fragment]){
        [navC popToRootViewControllerAnimated:TRUE];
        if(ary && ary.count > 0){
            [navC popToViewController:ary[0] animated:YES];
        }
    } else if (!fragment || [@"-1" isEqualToString:fragment] || [@"" isEqualToString:fragment]){
        if(ary){
            if(ary.count > 1) {
                [navC popToViewController:ary[ary.count-2] animated:YES];
            } else if(ary.count ==1){
                [navC popViewControllerAnimated:YES];
            }
        }
    } else if(isMinusHistory) {
        if(ary){
            int minusHistory = [fragment intValue];
            int idx = minusHistory+ary.count -1 ;
            if(idx<0){
                [XENP(iToast) toast:@"历史超出边界.退到根目录"];
                [navC popToRootViewControllerAnimated:TRUE];
            }else {
                [navC popToViewController:ary[idx] animated:YES];
            }
        }
    } else if (isNamedHistory){
        if(ary && ary.count > 1){
            int i = 0;
            for (UIViewController *vc in [ary reverseObjectEnumerator]){
                HistoryModel *hm = [vc getLastHistory];
                if(hm && [hm.fragment isEqualToString:fragment]){
                    [navC popToViewController:vc animated:YES];
                    return;
                }
                i++;
            }
        }
    } else {
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


- (nonnull UIViewController *)getContainer:(nonnull NSString *)scheme host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params  frame:(CGRect)frame{
    
    id<iDirect> direct = [self.directors objectForKey:scheme];
    UIViewController* container =[direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params frame:frame];
    return container;
    
}
 
- (void)push: (NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(nullable NSDictionary<NSString*,NSString*>*) query
        params:(NSDictionary<NSString*,id>*) params
        frame:(CGRect)frame{
    UInt64 now  = [[ NSDate date ] timeIntervalSince1970 ] * 1000;
    // 路由 throttle
    if(now - self.lastTimeStamp<500){
        self.lastTimeStamp = now;
        return;
    }else{
        self.lastTimeStamp = now;
    }
    
    // 复用上一次的 host
    if(host){
        pathname = pathname && (pathname.length!=0) ? pathname : @"/";
    } else {
        HistoryModel* hm= [[Unity sharedInstance].getCurrentVC.navigationController.viewControllers.lastObject getLastHistory];
        host = hm.host;
        NSAssert(host!=nil, @"host 不可为 nil");
        pathname = hm.pathname && (hm.pathname.length!=0) ? hm.pathname : @"/";
    }
    
    id<iDirect> direct = [self.directors objectForKey:scheme];
    
    // 路由mapping

    NSString* schemeAuthority = [NSString stringWithFormat:@"%@://%@",scheme,host];
    NSString* forceschemeAuthority= [self.forceMappings objectForKey:schemeAuthority];
    if(forceschemeAuthority){
        NSURL * u = [NSURL URLWithString:forceschemeAuthority];
        scheme = u.scheme;
        host = u.host;
        if(u.port){
            host = [NSString stringWithFormat:@"%@:%@",u.host,u.port];
        }
        [self push:scheme host:host pathname:pathname fragment:fragment query:query params:params frame:frame];
        return;
    }
    
    // 拿容器
    UIViewController *container = [direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params frame:[UIScreen mainScreen].bounds];

    if(!container){
        NSURL * fallbackUrl = [self fallback:host params:params pathname:pathname scheme:scheme];
        if(fallbackUrl){
            [self push:fallbackUrl.scheme host:fallbackUrl.host pathname:fallbackUrl.path fragment:fragment query:query params:params];
            return;
        }
    }
    if(!container){
#ifdef DEBUG
        NSString* msg = [NSString stringWithFormat:@"找不到路径: %@://%@%@",scheme,host,pathname];
        [XENP(iToast) toast:msg duration:.5f];
#endif
        return;
    }
    // 实在找不到,跳到默认错误页
//    NSAssert(container,@"why here, where is your container?");


    if([direct respondsToSelector:@selector(push:params:)]){
        [direct push:container params:params];
    }else{

        UINavigationController* navc = [Unity sharedInstance].getCurrentVC.navigationController;

        //  删除历史逻辑
        NSDictionary* nativeParams =  [params objectForKey:@"nativeParams"];
        int deleteHistory = 0;
        if(nativeParams){
            id deletable = [nativeParams objectForKey:@"__deleteHistory__"];
            if(deletable)
                deleteHistory =[deletable intValue];
        }
        deleteHistory = abs(deleteHistory);
//        NSAssert(deleteHistory>=0, @"__deleteHistory__ 必须大于等于 0");
        while(deleteHistory>0){
            [[Unity sharedInstance].getCurrentVC.navigationController popViewControllerAnimated:NO];
            deleteHistory--;
        }
        
        if(navc){
            [navc pushViewController:container animated:YES];
            HistoryModel* hm = [HistoryModel new];
            hm.fragment      = fragment;
            hm.host          = host;
            hm.pathname      = pathname;
            [container setCurrentHistory:hm];
        }else{
            // present　出来的，　不关注历史
            UIViewController* vc = [Unity sharedInstance].getCurrentVC;
            [vc presentViewController:container animated:YES completion:^{}];
        }
    }
}

// rn
- (void)push: (NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(nullable NSDictionary<NSString*,NSString*>*) query
        params:(NSDictionary<NSString*,id>*) params
        frame:(CGRect)frame
        moduleName:(NSString *)name {
    UInt64 now  = [[ NSDate date ] timeIntervalSince1970 ] * 1000;
    // 路由 throttle
    if(now - self.lastTimeStamp<500){
        self.lastTimeStamp = now;
        return;
    }else{
        self.lastTimeStamp = now;
    }
    
    // 复用上一次的 host
    if(host){
        pathname = pathname && (pathname.length!=0) ? pathname : @"/";
    } else {
        HistoryModel* hm= [[Unity sharedInstance].getCurrentVC.navigationController.viewControllers.lastObject getLastHistory];
        host = hm.host;
        NSAssert(host!=nil, @"host 不可为 nil");
        pathname = hm.pathname && (hm.pathname.length!=0) ? hm.pathname : @"/";
    }
    
    id<iDirect> direct = [self.directors objectForKey:scheme];
    
    // 路由mapping

    NSString* schemeAuthority = [NSString stringWithFormat:@"%@://%@",scheme,host];
    NSString* forceschemeAuthority= [self.forceMappings objectForKey:schemeAuthority];
    if(forceschemeAuthority){
        NSURL * u = [NSURL URLWithString:forceschemeAuthority];
        scheme = u.scheme;
        host = u.host;
        if(u.port){
            host = [NSString stringWithFormat:@"%@:%@",u.host,u.port];
        }
        [self push:scheme host:host pathname:pathname fragment:fragment query:query params:params frame:frame];
        return;
    }
    
    // 获取rn容器
    UIViewController *container = [direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params frame:[UIScreen mainScreen].bounds moduleName:name];

    if(!container){
        NSURL * fallbackUrl = [self fallback:host params:params pathname:pathname scheme:scheme];
        if(fallbackUrl){
            [self push:fallbackUrl.scheme host:fallbackUrl.host pathname:fallbackUrl.path fragment:fragment query:query params:params];
            return;
        }
    }
    if(!container){
#ifdef DEBUG
        NSString* msg = [NSString stringWithFormat:@"找不到路径: %@://%@%@",scheme,host,pathname];
        [XENP(iToast) toast:msg duration:.5f];
#endif
        return;
    }
    // 实在找不到,跳到默认错误页
//    NSAssert(container,@"why here, where is your container?");


    if([direct respondsToSelector:@selector(push:params:)]){
        [direct push:container params:params];
    }else{

        UINavigationController* navc = [Unity sharedInstance].getCurrentVC.navigationController;

        //  删除历史逻辑
        NSDictionary* nativeParams =  [params objectForKey:@"nativeParams"];
        int deleteHistory = 0;
        if(nativeParams){
            id deletable = [nativeParams objectForKey:@"__deleteHistory__"];
            if(deletable)
                deleteHistory =[deletable intValue];
        }
        deleteHistory = abs(deleteHistory);
//        NSAssert(deleteHistory>=0, @"__deleteHistory__ 必须大于等于 0");
        while(deleteHistory>0){
            [[Unity sharedInstance].getCurrentVC.navigationController popViewControllerAnimated:NO];
            deleteHistory--;
        }
        
        if(navc){
            [navc pushViewController:container animated:YES];
            HistoryModel* hm = [HistoryModel new];
            hm.fragment      = fragment;
            hm.host          = host;
            hm.pathname      = pathname;
            [container setCurrentHistory:hm];
        }else{
            // present　出来的，　不关注历史
            UIViewController* vc = [Unity sharedInstance].getCurrentVC;
            [vc presentViewController:container animated:YES completion:^{}];
        }
    }
}


- (void)addToTab: (UIViewController*) parent
        scheme:(NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(nullable NSString*) fragment
        query:(nullable NSDictionary<NSString*,id>*) query
          params:(nullable NSDictionary<NSString*,id>*) params frame:(CGRect)frame{
    
    id<iDirect> direct = [self.directors objectForKey:scheme];
    
    // 路由 mapping

    NSString* schemeAuthority = [NSString stringWithFormat:@"%@://%@",scheme,host];
    NSString* forceschemeAuthority= [self.forceMappings objectForKey:schemeAuthority];
    if(forceschemeAuthority){
        NSURL * u = [NSURL URLWithString:forceschemeAuthority];
        scheme = u.scheme;
        host = u.host;
        if(u.port){
            host = [NSString stringWithFormat:@"%@:%@",u.host,u.port];
        }
        [self addToTab:parent scheme:scheme host:host pathname:pathname fragment:fragment query:query params:params frame:frame];
        return;
    }
    
    UIViewController* container =  [direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params frame:frame];
 
    if(!container){
        // try fallback
        NSURL * fallbackUrl = [self fallback:host params:params pathname:pathname scheme:scheme];
        if(fallbackUrl){
            #ifdef DEBUG
                NSString* msg =[NSString stringWithFormat:@"fallback:%@",fallbackUrl];
                [XENP(iToast) toast:msg];
            #endif
            [self addToTab:parent scheme:fallbackUrl.scheme host:fallbackUrl.host pathname:fallbackUrl.path fragment:fragment query:query params:params frame:frame];
            return;
        }
    }
    // 实在找不到,跳到默认错误页
    NSAssert(container,@"why here, where is your container?");
    if(!container)return;
 

    [parent addChildViewController:container];
    container.view.frame = parent.view.frame;
    
    [parent.view addSubview:container.view];
    HistoryModel* hm = [HistoryModel new];
    hm.fragment      = fragment;
    hm.host          = host;
    hm.pathname      = pathname;
    [parent setCurrentHistory:hm];
}


// rn
- (void)addToTab: (UIViewController*) parent
          scheme:(NSString*) scheme
            host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(nullable NSString*) fragment
           query:(nullable NSDictionary<NSString*,id>*) query
          params:(nullable NSDictionary<NSString*,id>*) params
           frame:(CGRect)frame
      moduleName:(nonnull NSString *)name {
    
    id<iDirect> direct = [self.directors objectForKey:scheme];
    
    // 路由 mapping

    NSString* schemeAuthority = [NSString stringWithFormat:@"%@://%@",scheme,host];
    NSString* forceschemeAuthority= [self.forceMappings objectForKey:schemeAuthority];
    if(forceschemeAuthority){
        NSURL * u = [NSURL URLWithString:forceschemeAuthority];
        scheme = u.scheme;
        host = u.host;
        if(u.port){
            host = [NSString stringWithFormat:@"%@:%@",u.host,u.port];
        }
        [self addToTab:parent scheme:scheme host:host pathname:pathname fragment:fragment query:query params:params frame:frame];
        return;
    }
    
    UIViewController* container =  [direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params frame:frame moduleName:name];
    
    if(!container){
        // try fallback
        NSURL * fallbackUrl = [self fallback:host params:params pathname:pathname scheme:scheme];
        if(fallbackUrl){
            #ifdef DEBUG
                NSString* msg =[NSString stringWithFormat:@"fallback:%@",fallbackUrl];
                [XENP(iToast) toast:msg];
            #endif
            [self addToTab:parent scheme:fallbackUrl.scheme host:fallbackUrl.host pathname:fallbackUrl.path fragment:fragment query:query params:params frame:frame];
            return;
        }
    }
    // 实在找不到,跳到默认错误页
    NSAssert(container,@"why here, where is your container?");
    if(!container)return;
 

    [parent addChildViewController:container];
    container.view.frame = parent.view.frame;
    
    [parent.view addSubview:container.view];
    HistoryModel* hm = [HistoryModel new];
    hm.fragment      = fragment;
    hm.host          = host;
    hm.pathname      = pathname;
    [parent setCurrentHistory:hm];
}


- (NSURL *)fallback:(NSString * _Nullable)host params:(NSDictionary<NSString *,id> * _Nullable)params pathname:(NSString * _Nonnull)pathname scheme:(NSString * _Nonnull)scheme {
    static NSString* FALL_BACK_KEY = @"__fallback__";
    NSDictionary* nativeParams =  [params objectForKey:@"nativeParams"];
    NSString* fallback = nil;
    if(nativeParams){
        id _fallback = [nativeParams objectForKey:FALL_BACK_KEY];
        if(_fallback){
            fallback =_fallback;
            // 必须删除,防止循环 fallback
            [[nativeParams mutableCopy] removeObjectForKey:FALL_BACK_KEY];
        }
    }
    // fallback: schem + host + path
    NSURL* fallbackUrl = [NSURL URLWithString:fallback];
    
    if(!fallbackUrl){
        // 使用降级表
        NSString* schemeHostPath = [NSString stringWithFormat:@"%@://%@%@",scheme,host,pathname];
        NSString* fallback= [self.fallbackMappings objectForKey:schemeHostPath];
        fallbackUrl = [NSURL URLWithString:fallback];
    }
    return fallbackUrl;
}
- (void) addFallbackRouter:(NSString*) schemeHostPath fallback:(NSString*) fallback{
    [self.fallbackMappings setObject:fallback forKey:schemeHostPath];
}
 
- (void) addMappingRouter:(NSString*) schemeHostPath mappingHostPath:(NSString*) mapping{
    [self.forceMappings setObject:mapping forKey:schemeHostPath];
}

- (NSString *)formAuthority:(NSURL *)url {
    NSString* authority = [NSString stringWithFormat:@"%@%@%@",url.host,url.port?@":":@"",url.port?url.port:@""];
    return authority;
}

- (void)push:(nonnull NSString *)uri params:(nullable NSDictionary<NSString *,id> *)params frame:(CGRect)frame{
    NSURL* url = [XToolDataConverter SPAUrl2StandardUrlWithPort:uri];
    NSString * authority = [self formAuthority:url];
    NSString* path =[NSString stringWithFormat:@"%@%@",url.path,url.hasDirectoryPath?@"/":@""];
    [self push:url.scheme host:authority pathname:path fragment:url.fragment query:url.uq_queryDictionary params:params];
}

// rn
- (void)push:(NSString *)uri moduleName:(NSString *)name params:(NSDictionary<NSString *,id> *)params frame:(CGRect)frame {
    NSURL* url = [XToolDataConverter SPAUrl2StandardUrlWithPort:uri];
    NSString * authority = [self formAuthority:url];
    NSString* path =[NSString stringWithFormat:@"%@%@",url.path,url.hasDirectoryPath?@"/":@""];
    [self push:url.scheme host:authority pathname:path fragment:url.fragment query:url.uq_queryDictionary params:params moduleName:name];
}

- (void)push:(nonnull NSString *)scheme host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params moduleName:(NSString *)name {
    [self push:scheme host:host pathname:pathname fragment:fragment query:query params:params frame:[UIScreen mainScreen].bounds moduleName:name];
}

- (void)addToTab:(nonnull UIViewController *)parent uri:(nonnull NSString *)uri params:(nullable NSDictionary<NSString *,id> *)params frame:(CGRect)frame {
    NSURL* url = [XToolDataConverter SPAUrl2StandardUrlWithPort:uri];
    NSString * authority = [self formAuthority:url];
    NSString* path =[NSString stringWithFormat:@"%@%@",url.path,url.hasDirectoryPath?@"/":@""];
    [self addToTab:parent scheme:url.scheme host:authority pathname:path fragment:url.fragment query:url.uq_queryDictionary params:params frame:frame];
}

- (void)addToTab:(UIViewController *)parent uri:(NSString *)uri moduleName:(NSString *)name params:(NSDictionary<NSString *,id> *)params frame:(CGRect)frame {
    NSURL* url = [XToolDataConverter SPAUrl2StandardUrlWithPort:uri];
    NSString * authority = [self formAuthority:url];
    NSString* path =[NSString stringWithFormat:@"%@%@",url.path,url.hasDirectoryPath?@"/":@""];
    [self addToTab:parent scheme:url.scheme host:authority pathname:path fragment:url.fragment query:url.uq_queryDictionary params:params frame:frame moduleName:name];
}

- (void)push:(nonnull NSString *)scheme host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
    [self push:scheme host:host pathname:pathname fragment:fragment query:query params:params frame:[UIScreen mainScreen].bounds];
}



- (void)push:(nonnull NSString *)uri params:(nullable NSDictionary<NSString *,id> *)params {
    [self push:uri params:params frame:[UIScreen mainScreen].bounds];
}
@end
 
