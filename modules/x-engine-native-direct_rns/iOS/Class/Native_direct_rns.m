//
//  Native_direct_rns.m
//  direct_rns
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_rns.h"
#import "XENativeContext.h"
#import "Unity.h"
#import "NSURL+QueryDictionary.h"
#import <x-engine-native-core/Unity.h>
#import "ReactNativeViewController.h"

@interface Native_direct_rns()
@property (nonatomic, strong) id<iDirect>  rnsDirect;
@end

@implementation Native_direct_rns
NATIVE_MODULE(Native_direct_rns)

- (NSString*) moduleId{
    return @"com.zkty.native.direct_rns";
}
- (nonnull NSString *)protocol {
    return @"rns:";
}
-(NSString*) scheme{
    return @"rns";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
}

- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params frame:(CGRect)frame   {
    
    if(!protocol){
        protocol = [self protocol];
    }
    
    id rns_params = params[@"__RN__"];
    NSAssert(rns_params  , @"__RN__ 不存在");
    if(!rns_params) return nil;
    
    id moduleName = rns_params[@"moduleName"];
    NSAssert(moduleName  , @"moduleName 不存在");
    if(!moduleName) return nil;

    
    BOOL isHideNavBar = [params[@"hideNavbar"] boolValue];
    NSString *finalUrl = @"";
    
    
    NSAssert(!fragment || ![fragment hasPrefix:@"#"]  , @"fragment 不需要加#");
    fragment = (fragment && fragment.length>0) ? [NSString stringWithFormat:@"#%@",fragment] : @"";
    NSString* queryStr   = query.uq_URLQueryString && query.uq_URLQueryString.length>0 ? [NSString stringWithFormat:@"?%@",query.uq_URLQueryString]:@"";
    
    finalUrl = [NSString stringWithFormat:@"%@//%@%@%@%@",protocol,host,pathname,fragment,queryStr];
    
    ReactNativeViewController *vc =  [[ReactNativeViewController alloc] initWithUrl:finalUrl withHiddenNavBar:isHideNavBar webviewFrame:frame moduleName:moduleName];
    vc.hidesBottomBarWhenPushed = YES;
    return  vc;
}
@end

