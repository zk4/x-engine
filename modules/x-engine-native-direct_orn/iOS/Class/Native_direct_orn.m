//
//  Native_direct_orn.m
//  direct_orn
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_orn.h"
#import "XENativeContext.h"
#import "Unity.h"
#import "NSURL+QueryDictionary.h"
#import <x-engine-native-core/Unity.h>
#import "ReactNativeViewController.h"

@interface Native_direct_orn()
@property (nonatomic, strong) id<iDirect>  ornDirect;
@end

@implementation Native_direct_orn
NATIVE_MODULE(Native_direct_orn)

- (NSString*) moduleId{
    return @"com.zkty.native.direct_orn";
}
- (nonnull NSString *)protocol {
    return @"orn:";
}
-(NSString*) scheme{
    return @"orn";
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
    
    id orn_params = params[@"__RN__"];
    NSAssert(orn_params  , @"__RN__ 不存在");
    if(!orn_params) return nil;
    
    id moduleName = orn_params[@"moduleName"];
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

