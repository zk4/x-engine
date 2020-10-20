//
//  __xengine__module_engine.m
//
//  Created by zk on 2020/8/30.
//

#import "__xengine__module_engine.h"
#import "micros.h"
//#import <x-engine-module-engine/MircroAppController.h>
//#import "UIViewController+.h"
//#import "Unity.h"

@interface __xengine__module_engine()
 
@end
 @implementation __xengine__module_engine

- (instancetype)init{
    self = [super init];
    return self;
}

- (NSString *)moduleId{
    return @"com.zkty.module.engine";
}

//- (void) pushMicroApp:(NSDictionary *)param complate:(XEngineCallBack)completionHandler{
//     if (param.count == 0) {
//        [self showErrorAlert:@"args not exists"];
//        return;
//    }
//
//    NSString* appid = [NSString stringWithFormat:@"%@",param[@"appid"]];
//    MircroAppController *mac = [[MircroAppController alloc] initWithMicroAppId:appid];
//    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
//    [topVC pushViewController:mac];
//}
//
//- (void) getCurrentMicroVC{
//
//
//}

@end
