//
//  Native_geo.m
//  geo
//


#import "Native_geo.h"
#import "XENativeContext.h"

@interface Native_geo()
{ }
@end

@implementation Native_geo
NATIVE_MODULE(Native_geo)

 - (NSString*) moduleId{
    return @"com.zkty.native.geo";
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
 
