//
//  Native_toast.m
//  toast
//


#import "Native_toast.h"
#import "XENativeContext.h"
#import "UIView+Toast.h"
#import "Unity.h"
@interface Native_toast()
{
    
    BOOL _showToast;
}
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
    _showToast = NO;
}

- (void)toastWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2){
    if (_showToast) {
              va_list args;
              va_start(args, format);
              NSString *s = [[NSString alloc] initWithFormat:format arguments:args] ;
              va_end(args);
              [self toast:s];
    }

}


- (void)toast:(NSString *)msg{
    if (_showToast) {
            dispatch_async(dispatch_get_main_queue(), ^{
             [[Unity sharedInstance].getCurrentVC.view makeToast:msg
                                                       duration:3.0
                                                       position:CSToastPositionTop];
            });
    }

}
- (void)toast:(NSString *)msg duration:(NSTimeInterval)duration{
    if (_showToast) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[Unity sharedInstance].getCurrentVC.view makeToast:msg
                                                       duration:duration
                                                       position:CSToastPositionTop];
            });
    }

}

- (void)toastCurrentView:(NSString *)msg duration:(NSTimeInterval)duration{
    if (_showToast) {
            dispatch_async(dispatch_get_main_queue(), ^{
        
            [[Unity sharedInstance].getCurrentVC.view makeToast:msg
                                                       duration:duration
                                                       position:CSToastPositionTop];
            });
    }

}


@end
 
