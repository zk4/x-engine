//
//  xengine__module_wallet.m
//  wallet
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_wallet.h"
#import <XEngineContext.h>
#import <micros.h>
#import <RecyleWebViewController.h>
#import <XEngineWebView.h>
#import <Unity.h>
#import "TZWalletSDK.h"
@interface __xengine__module_wallet()
{
    NSTimer * timer ;
//    ContinousDTO* adto;
    void(^hanlder)(id value,BOOL isComplete);
    int value;
    NSString* event;

}
@end

@implementation __xengine__module_wallet

- (instancetype)init{
    self = [super init];
//    [[TZWalletSDK shareInstance]setWalletSDKAddress:@""];
    return self;
}

- (void) _callWallet:(WalletDTO*) dto complete:(void (^)(BOOL complete)) completionHandler{
    NSMutableDictionary *inf = [NSMutableDictionary dictionary];
    [inf setObject:dto.platMerCstNo forKey:@"platMerCstNo"];
    [inf setObject:dto.businessCstName forKey:@"businessCstName"];
    [inf setObject:dto.businessCstNo forKey:@"businessCstNo"];
    [inf setObject:dto.businessCstMobileNo forKey:@"businessCstMobileNo"];
    [[TZWalletSDK shareInstance]callWalletWithInfo:inf withScheme:dto.appScheme finishBlock:^{
        
    }];
}
@end
 
