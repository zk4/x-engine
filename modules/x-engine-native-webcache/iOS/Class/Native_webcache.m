//
//  Native_webcache.m
//  webcache
//


#import "Native_webcache.h"
#import "XENativeContext.h"

@interface Native_webcache()
{ }
@end

@implementation Native_webcache
NATIVE_MODULE(Native_webcache)

 - (NSString*) moduleId{
    return @"com.zkty.native.webcache";
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
 
