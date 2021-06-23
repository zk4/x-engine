//
//  Native_geo_gaode.m
//  geo_gaode
//


#import "Native_geo_gaode.h"
#import "XENativeContext.h"

@interface Native_geo_gaode()
{ }
@end

@implementation Native_geo_gaode
NATIVE_MODULE(Native_geo_gaode)

 - (NSString*) moduleId{
    return @"com.zkty.native.geo_gaode";
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
 
