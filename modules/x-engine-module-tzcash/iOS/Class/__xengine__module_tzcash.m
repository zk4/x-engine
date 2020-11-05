//
//  xengine__module_tzcash.m
//  tzcash
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_tzcash.h"
#import <XEngineContext.h>
#import <micros.h>
#import <UIViewController+.h>
#import <JSONToDictionary.h>
#import <RecyleWebViewController.h>
#import <XEngineWebView.h>
#import <Unity.h>
#import "TZCashSDK.h"

@interface __xengine__module_tzcash()
@end

@implementation __xengine__module_tzcash

- (void)_callPaymentSDK:(TZCashDTO *)dto complete:(void (^)(TZCashRetDTO *, BOOL))completionHandler {
    NSMutableDictionary *orderInf = [NSMutableDictionary dictionary];
    [orderInf setObject:dto.orderNoList forKey:@"orderNoList"];
    [orderInf setObject:dto.businessCstNo forKey:@"businessCstNo"];
    [orderInf setObject:dto.platMerCstNo forKey:@"platMerCstNo"];
    TZCashSDK *cashsdk = [TZCashSDK shareInstance];
    [cashsdk callPaymentWithOrderInfo:orderInf payfinishBlock:^(NSString *orderStatus) {
        TZCashRetDTO* d = [TZCashRetDTO new];
        d.orderStatus=orderStatus;
        completionHandler(d, YES);
    }];
}

@end
 
