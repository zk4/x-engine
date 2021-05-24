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
    NSString * finalUrl = @"";
    
    pathname = pathname?pathname:@"";
    fragment = fragment?[NSString stringWithFormat:@"#%@",fragment]:@"";
    
    if (query) {
        NSArray *keys = query.allKeys;
        NSArray *values = query.allValues;
        NSString *forString = [NSString string];
        for (NSInteger i = 0; i<keys.count; i++) {
            forString = [forString stringByAppendingFormat:@"%@=%@&", keys[i], values[i]];
        }
        NSString *cutString = [forString substringWithRange:NSMakeRange(0, [forString length] - 1)];
        NSString *finalQueryString;
        finalQueryString = [cutString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        finalUrl = [NSString stringWithFormat:@"%@//%@%@%@?%@",protocol,host,pathname,fragment,finalQueryString];
    } else {
        finalUrl = [NSString stringWithFormat:@"%@//%@%@%@",protocol,host,pathname,fragment];
    }
    NSURL *jsCodeLocation = [NSURL URLWithString:finalUrl];

    RCTRootView *rootView =
      [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                  moduleName: @"RNHighScores"
                           initialProperties:
                             params
                               launchOptions: nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:vc animated:YES ];
}

- (nonnull NSString *)scheme {
    return @"rn";
}

@end
 
