//
//  Native_localstorage__webproxy.m
//  localstorage__webproxy
//


#import "Native_localstorage__webproxy.h"
#import "XENativeContext.h"

@interface Native_localstorage__webproxy()
{ }
@end

@implementation Native_localstorage__webproxy
NATIVE_MODULE(Native_localstorage__webproxy)

 - (NSString*) moduleId{
    return @"com.zkty.native.localstorage__webproxy";
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
 
