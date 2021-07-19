//
//  Native_direct_native.m
//  direct_native
//


#import "Native_direct_native.h"
#import "XENativeContext.h"
#import "MGJRouter.h"
@interface Native_direct_native()
{ }
@end

@implementation Native_direct_native
NATIVE_MODULE(Native_direct_native)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_native";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
 
- (void)back:(nonnull NSString *)host fragment:(nonnull NSString *)fragment {
     
}

- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
    NSString* url = [NSString stringWithFormat:@"%@//%@%@",protocol,host,pathname];
    [MGJRouter openURL:url withUserInfo:@{@"query":query?query:@{},@"params":params?params:@{}} completion:nil];
    return nil;
}

- (nonnull NSString *)protocol {
    return @"native:";
}

- (void)push:(nonnull UIViewController *)container params:(nullable NSDictionary<NSString *,id> *)params {
    // TODO: 暂时由 getContainer 完成 push 操作
    NSLog(@"暂时由 getContainer 完成native: push 操作");
}

- (nonnull NSString *)scheme {
    return @"native";
}

@end
 
