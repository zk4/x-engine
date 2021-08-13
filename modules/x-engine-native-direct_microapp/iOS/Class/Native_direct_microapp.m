//
//  Native_direct_microapp.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "Native_direct_microapp.h"
#import "XENativeContext.h"
#import "Unity.h"
#import "HistoryModel.h"
#import "UIViewController+Tag.h"
#import "iUpdator.h"
#import "iToast.h"


#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

@interface Native_direct_microapp ()
@property (nonatomic, strong) id<iDirect>  microappDirect;
@property (nonatomic, strong) id<iToast> toast;

@end
@implementation Native_direct_microapp
NATIVE_MODULE(Native_direct_microapp)

- (NSString*) moduleId{
    return @"com.zkty.native.direct_microapp";
}

- (int) order{
    return 0;
}
- (nonnull NSString *)protocol {
    return @"file:";
}
-(NSString*) scheme{
    return @"microapp";
}

- (void)afterAllNativeModuleInited{
   NSArray* modules= [[XENativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        // 暂时 与 omp 使用相同的逻辑
        if([[direct scheme] isEqualToString:@"omp"]){
            self.microappDirect = direct;
            return;
        }
    }
}


- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
 
 
    if(host && host.length>0){
        // microapp 的 host 要特殊处理.
        // 当第一次打开时, 因为这里传过来的时 microappid => host, pathname
        NSString* rootPath =  [XENP(iUpdator) getPath:host];
        if(!rootPath){
            NSString* errStr = [NSString stringWithFormat:@"找不到本地微应用:%@",host];
            [_toast toast:errStr];
            return nil;
        }

        pathname=  [NSString stringWithFormat:@"%@index.html", rootPath];
        // 供后面构造字符串用,不会出现 nil
        host=@"";
    }else{
       HistoryModel* hm= [[Unity sharedInstance].getCurrentVC.navigationController.viewControllers.lastObject getLastHistory];
       pathname=hm.pathname;
    }
    return [self.microappDirect getContainer:protocol host:host pathname:pathname fragment:fragment query:query params:params];
}

 
 
@end
