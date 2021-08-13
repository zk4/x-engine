//
//  Native_direct_microapp.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "Native_direct_microapp.h"
#import "XENativeContext.h"
#import "MicroAppLoader.h"
#import "Unity.h"
#import "HistoryModel.h"
#import "UIViewController+Tag.h"

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

@interface Native_direct_microapp ()
@property (nonatomic, strong) id<iDirect>  microappDirect;
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


- (void)showErrorAlert:(NSString *)errorString
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:errorString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:action];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    });
}


- (nonnull UIViewController *)getContainer:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
    
    int version = 0;
    NSString *packageInfoPath = [kDocumentPath stringByAppendingPathComponent:@"packageInfo.json"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:packageInfoPath]) {
        version = 0;
    } else {
        version = [self getLocalVersionWithHostName:host];
    }
    

    if(host && host.length>0){
        // microapp 的 host 要特殊处理.
        // 当第一次打开时, 因为这里传过来的时 microappid => host, pathname
        pathname = [[MicroAppLoader sharedInstance] getMicroAppHost:host withVersion:version];
        if(!pathname){
            NSString* errStr = [NSString stringWithFormat:@"找不到本地微应用:%@",host];
            [self showErrorAlert:errStr];
            return nil;
        }
        // 供后面构造字符串用,不会出现 nil
        host=@"";
    }else{
       HistoryModel* hm= [[Unity sharedInstance].getCurrentVC.navigationController.viewControllers.lastObject getLastHistory];
       pathname=hm.pathname;
    }
    return [self.microappDirect getContainer:protocol host:host pathname:pathname fragment:fragment query:query params:params];
}

// 获取本地版本号
- (int)getLocalVersionWithHostName:(NSString *)hostName {
    // 读出name对应的版本号
    int version = 0;
    NSString *packageInfoPath = [kDocumentPath stringByAppendingPathComponent:@"packageInfo.json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:packageInfoPath];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *array = dict[@"data"];
    for (NSDictionary *dict in array) {
        NSString *name = [NSString stringWithFormat:@"%@", dict[@"name"]];
        if ([name isEqualToString:hostName]) {
            version = [dict[@"version"] intValue];
        }
    }
    return version;
}
@end
