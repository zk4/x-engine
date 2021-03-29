//
//  H5DirectModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "H5DirectModule.h"
#import "NativeContext.h"
#import "XEOneWebViewPool.h"
#import "XEOneWebViewPoolModel.h"
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "HistoryModel.h"
#import "GlobalState.h"
 
@interface H5DirectModule ()
@property (nonatomic, strong) id<iDirect>  h5Direct;
@end

@implementation H5DirectModule
NATIVE_MODULE(H5DirectModule)


- (NSString*) moduleId{
    return @"com.zkty.native.direct.h5";
}
- (int) order{
    return 0;
}

-(NSString*) scheme{
    return @"h5";
}
- (void)afterAllNativeModuleInited{
   NSArray* modules= [[NativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        // 暂时 与 omp 使用相同的逻辑
        if([[direct scheme] isEqualToString:@"omp"]){
            self.h5Direct = direct;
            return;
        }

    }
}
- (void)back:(NSString*) host path:(NSString*) path{
    [self.h5Direct back:host path:path];
}

- (void)push:( NSString *)host path:(nonnull NSString *)path query:( NSDictionary<NSString *,NSString *> *)query hideNavbar:(BOOL)hideNavbar {
    [self.h5Direct push:host path:path query:query hideNavbar:hideNavbar];

}
@end