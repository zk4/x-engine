//
//  Native_tabbar.m
//  tabbar
//


#import "Native_tabbar.h"
#import "XENativeContext.h"
#import "iTabbarDelegate.h"

@interface Native_tabbar()
@property (nonatomic, strong) id<iTabbarDelegate> delegate;

@end

@implementation Native_tabbar
NATIVE_MODULE(Native_tabbar)

 - (NSString*) moduleId{
    return @"com.zkty.native.tabbar";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
 
- (UIViewController*)getCurrentTabItemVC {
    return [self.delegate getCurrentTabItemVC];
}

- (void)registerDelegate:(id)delegate {
    self.delegate=delegate;
}

@end
 
