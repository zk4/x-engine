//
//  Native_direct_native.m
//  direct_native
//


#import "Native_direct_native.h"
#import "XENativeContext.h"

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
-(NSString*) test{
    return @"test";
}
@end
 
