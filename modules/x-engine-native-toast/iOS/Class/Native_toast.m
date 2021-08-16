//
//  Native_toast.m
//  toast
//


#import "Native_toast.h"
#import "XENativeContext.h"
#import "UIView+Toast.h"
#import "Unity.h"
@interface Native_toast()
{ }
@end

@implementation Native_toast
NATIVE_MODULE(Native_toast)

 - (NSString*) moduleId{
    return @"com.zkty.native.toast";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    [CSToastManager setQueueEnabled:YES];
} 
- (void)toast:(NSString *)msg{
    [[Unity sharedInstance].getCurrentVC.view makeToast:msg
                                               duration:3.0
                                               position:CSToastPositionTop];
}
- (void)toast:(NSString *)msg duration:(NSTimeInterval)duration{
    [[Unity sharedInstance].getCurrentVC.view makeToast:msg
                                               duration:duration
                                               position:CSToastPositionTop];
}
@end
 
