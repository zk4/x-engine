//
//  Native_direct_rn.m
//  direct_rn
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_rn.h"
#import "XENativeContext.h"
#import "Unity.h"
#import "NSURL+QueryDictionary.h"
#import <x-engine-native-core/Unity.h>
//#import "ReactNativeViewController.h"

@interface Native_direct_rn()
@property (nonatomic, strong) id<iDirect>  rnDirect;
@end

@implementation Native_direct_rn
NATIVE_MODULE(Native_direct_rn)

- (NSString*) moduleId{
    return @"com.zkty.native.direct_rn";
}
- (nonnull NSString *)protocol {
    return @"rn:";
}
-(NSString*) scheme{
    return @"rn";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
}

- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params frame:(CGRect)frame moduleName:(NSString *)name {
    
    if(!protocol){
        protocol = [self protocol];
    }
    
    BOOL isHideNavBar = [params[@"hideNavbar"] boolValue];
    NSString *finalUrl = @"";
    
    
    NSAssert(!fragment || ![fragment hasPrefix:@"#"]  , @"fragment 不需要加#");
    fragment = (fragment && fragment.length>0) ? [NSString stringWithFormat:@"#%@",fragment] : @"";
    NSString* queryStr   = query.uq_URLQueryString && query.uq_URLQueryString.length>0 ? [NSString stringWithFormat:@"?%@",query.uq_URLQueryString]:@"";
    
    finalUrl = [NSString stringWithFormat:@"%@//%@%@%@%@",protocol,host,pathname,fragment,queryStr];
    
    ReactNativeViewController *vc =  [[ReactNativeViewController alloc] initWithUrl:finalUrl  withHiddenNavBar:isHideNavBar webviewFrame:frame];
    vc.moduleName = name;
    vc.hidesBottomBarWhenPushed = YES;
    return  vc;
}

@end

