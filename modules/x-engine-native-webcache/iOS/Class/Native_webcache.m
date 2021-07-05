//
//  Native_webcache.m
//  webcache
//


#import "Native_webcache.h"
#import "XENativeContext.h"
#import "micros.h"
#import "NSURLProtocol+WebKitSupport.h"
//#import "ReplacingImageURLProtocol.h"
#import "MyURLProtocol.h"

#import <UIKit/UIKit.h>


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
- (instancetype)init {
    self = [super init];
    if (self) {
 
 
        [[NSNotificationCenter defaultCenter]
         addObserverForName:UIApplicationDidFinishLaunchingNotification
         object:nil
         queue:nil
         usingBlock:^(NSNotification *note) {
            [NSURLProtocol registerClass:[MyURLProtocol class]];
            for (NSString* scheme in @[@"http", @"https"]) {
                    [NSURLProtocol wk_registerScheme:scheme];
            }
        }];


    }
    
    return self;
}

@end
 
