//
//  JSI_xxxx.m
//  xxxx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_xxxx.h"
#import "JSIContext.h"
#import "NativeContext.h"

@interface JSI_xxxx()
@end

@implementation JSI_xxxx
JSI_MODULE(JSI_xxxx)

- (void)afterAllJSIModuleInited {
}

- (void)_setNavBarHidden:(NavHiddenBarDTO *)dto complete:(void (^)(BOOL))completionHandler { 
    <#code#>
}

- (void)_setNavTitle:(NavTitleDTO *)dto complete:(void (^)(BOOL))completionHandler { 
    <#code#>
}

@end
 
