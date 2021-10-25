//
//  Native_direct_http.m
//  direct_http
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 x-engine. All rights reserved.


#import "Native_direct_http.h"
#import "XENativeContext.h"
#import "WebViewFactory.h"
#import "Unity.h"
#import "NormalWebViewController.h"
#import "NSURL+QueryDictionary.h"

@interface Native_direct_http ()
@property (nonatomic, strong) id<iDirect>  microappDirect;
@end

@implementation Native_direct_http
NATIVE_MODULE(Native_direct_http)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_http";
}
- (nonnull NSString *)protocol {
    return @"http:";
}
-(NSString*) scheme{
    return @"http";
}
- (int) order{
    return 0;
}
- (void)afterAllNativeModuleInited{
 
}



 

- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params frame:(CGRect)frame {
    
    if(!protocol){
        protocol = [self protocol];
    }
    
    BOOL isHideNavBar = [params[@"hideNavbar"] boolValue];
    NSString *finalUrl = @"";

   
    NSAssert(!fragment || ![fragment hasPrefix:@"#"]  , @"fragment 不需要加#");
    fragment = (fragment && fragment.length>0) ? [NSString stringWithFormat:@"#%@",fragment] : @"";
    NSString* queryStr   = query.uq_URLQueryString && query.uq_URLQueryString.length>0 ? [NSString stringWithFormat:@"?%@",query.uq_URLQueryString]:@"";
    
    finalUrl = [NSString stringWithFormat:@"%@//%@%@%@%@",protocol,host,pathname,fragment,queryStr];

    NormalWebViewController *vc =  [[NormalWebViewController alloc] initWithUrl:finalUrl  withHiddenNavBar:isHideNavBar webviewFrame:frame];
    vc.hidesBottomBarWhenPushed = YES;
    return  vc;
}
@end
 
