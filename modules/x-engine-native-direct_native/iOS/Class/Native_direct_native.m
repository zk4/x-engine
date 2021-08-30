//
//  Native_direct_native.m
//  direct_native
//


#import "Native_direct_native.h"
#import "XENativeContext.h"
#import <Unity.h>
@interface Native_direct_native()
@property (nonatomic, strong) NSMutableDictionary<NSString*,id>* routes;

 
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
    self.routes = [NSMutableDictionary new];
}  

- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
    
    // TODO: find matching url nativeCreator
    NSString* url = [NSString stringWithFormat:@"%@//%@%@",protocol,host,pathname];
    NativeVCCreator nv = [self.routes objectForKey:url];
    NSAssert(nv, @"没注册这个路由");
    UIViewController* vc = nv(protocol,   host,  pathname,   fragment,  query,  params);
    return vc;
}

- (nonnull NSString *)protocol {
    return @"native:";
}

- (nonnull NSString *)scheme {
    return @"native";
}

- (void) registerNativeRouter:(NSString*) urlPattern nativeVCCreator:(NativeVCCreator) nativeVCCreator{
    [self.routes setObject:nativeVCCreator forKey:urlPattern];
}
@end
 
