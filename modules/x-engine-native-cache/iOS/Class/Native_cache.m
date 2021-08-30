//
//  Native_cache.m
//  cache
//


#import "Native_cache.h"
#import "XENativeContext.h"

@interface Native_cache()
{ }
@end

@implementation Native_cache
NATIVE_MODULE(Native_cache)

 - (NSString*) moduleId{
    return @"com.zkty.native.cache";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
-(NSString*) test{
    return @"test";
}
@end
 
