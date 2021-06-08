//
//  Native_hummer.m
//  hummer
//


#import "Native_hummer.h"
#import "XENativeContext.h"
#import <Hummer/Hummer.h>

@interface Native_hummer()
{ }
@end

@implementation Native_hummer
NATIVE_MODULE(Native_hummer)

 - (NSString*) moduleId{
    return @"com.zkty.native.hummer";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    [Hummer startEngine:nil];
 
} 
-(NSString*) test{
    return @"test";
}
@end
 
