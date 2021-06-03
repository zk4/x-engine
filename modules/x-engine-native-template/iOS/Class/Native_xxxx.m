//
//  Native_xxxx.m
//  xxxx
//


#import "Native_xxxx.h"
#import "XENativeContext.h"

@interface Native_xxxx()
{ }
@end

@implementation Native_xxxx
NATIVE_MODULE(Native_xxxx)

 - (NSString*) moduleId{
    return @"com.zkty.native.xxxx";
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
 
