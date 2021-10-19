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
    dispatch_async(dispatch_get_main_queue(), ^{

    [[UIApplication sharedApplication].keyWindow makeToast:msg
                                               duration:3.0
                                               position:CSToastPositionTop];
    });
}
- (void)toast:(NSString *)msg duration:(NSTimeInterval)duration{
    dispatch_async(dispatch_get_main_queue(), ^{

    [[UIApplication sharedApplication].keyWindow makeToast:msg
                                               duration:duration
                                               position:CSToastPositionTop];
    });
}

- (void)toastCurrentView:(NSString *)msg duration:(NSTimeInterval)duration{
    dispatch_async(dispatch_get_main_queue(), ^{

    [[Unity sharedInstance].getCurrentVC.view makeToast:msg
                                               duration:duration
                                               position:CSToastPositionTop];
    });
}


@end
 
