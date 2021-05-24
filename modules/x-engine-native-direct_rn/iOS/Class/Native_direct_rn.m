//
//  Native_direct_rn.m
//  direct_rn
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct_rn.h"
#import "XENativeContext.h"
#import <x-engine-native-core/Unity.h>
#import <React/RCTRootView.h>

@interface Native_direct_rn()
{ }
@end

@implementation Native_direct_rn
NATIVE_MODULE(Native_direct_rn)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct_rn";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
}

 
- (void)back:(nonnull NSString *)host fragment:(nonnull NSString *)fragment {
    /// TODO
}

- (nonnull NSString *)protocol {
    return @"http:";
}

- (void)push:(nonnull NSString *)protocol host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://10.2.128.80:8081/index.bundle?platform=ios"];

    RCTRootView *rootView =
      [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                  moduleName: @"RNHighScores"
                           initialProperties:
                             @{
                               @"scores" : @[
                                 @{
                                   @"name" : @"Alex",
                                   @"value": @"42"
                                  },
                                 @{
                                   @"name" : @"Joel",
                                   @"value": @"10"
                                 }
                               ]
                             }
                               launchOptions: nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES ];
}

- (nonnull NSString *)scheme {
    return @"rn";
}

@end
 
