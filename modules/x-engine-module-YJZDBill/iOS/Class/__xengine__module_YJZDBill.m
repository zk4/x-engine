//
//  xengine__module_yjzdbill.m
//  yjzdbill
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_yjzdbill.h"
#import <XEngineContext.h>
#import <micros.h>
 
#import <RecyleWebViewController.h>
#import <XEngineWebView.h>
#import <Unity.h>
#import <YJZDBill/YJBillPlatform.h>
extern XEngineWebView* s_webview;
@interface __xengine__module_yjzdbill()
{
    NSTimer * timer ;
    void(^hanlder)(id value,BOOL isComplete);
    int value;
}
@end

#ifdef UAT_ENV
static NSString *const cashSDKAddress = @"http://xpay-h5-uat.linli.timesgroup.cn:10005/pages/indexSdk.html";
static NSString *const billSDKAddress = @"http://xpay-bill-uat.linli.timesgroup.cn:10006";
#elif SIT_ENV
static NSString *const cashSDKAddress = @"http://xpay-h5-sit.linli.timesgroup.cn:10005";
static NSString *const billSDKAddress = @"http://xpay-bill-sit.linli.timesgroup.cn:1000";
#else
static NSString *const cashSDKAddress = @"http://xpay-h5-prod-linli.timesgroup.cn";
static NSString *const billSDKAddress = @"http://xpay-bill-prod-linli.timesgroup.cn";
#endif


@implementation __xengine__module_yjzdbill
- (instancetype)init{
    self = [super init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //UniversalLink配置
    [[YJBillPlatform sharedSingleton] setWeChatAppId:@"wx2318e010458e4805" UniversalLink:@"https://m-center-prod-linli.timesgroup.cn"];
    //支付收银台地址、账单中心地址配置
    [[YJBillPlatform sharedSingleton] setCashSDKAddress:cashSDKAddress billSDKAddress:billSDKAddress];

    return self;
}

- (void)didBecomeActive{
    NSLog(@"========开始查证======");
    [[YJBillPlatform sharedSingleton] payVerification];
}

- ( void )callProgress:(NSDictionary *) args :(void (^)(YJBillRetDTO *, BOOL))completionHandler
{
    value=10;
    hanlder=completionHandler;
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(onTimer:)
                                            userInfo:nil
                                             repeats:YES];
}
 
//支付
- (void)_YJBillPayment:(YJBillDTO *)dto complete:(void (^)(YJBillRetDTO *, BOOL))completionHandler {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:dto.businessCstNo forKey:@"businessCstNo"]; //会员标识
    [dictM setObject:dto.platMerCstNo forKey:@"platMerCstNo"]; //预下单平台商户号
    [dictM setObject:dto.tradeMerCstNo forKey:@"tradeMerCstNo"]; //预下单交易商户号
    [dictM setObject:dto.billNo forKey:@"billNo"]; //业务系统订单号

     
    [[YJBillPlatform sharedSingleton] billPaymentWithOrderInfo:dictM appScheme:dto.appScheme payType:dto.payType payfinishBlock:^(id  _Nonnull responseObject, NSString * _Nonnull message) {
        NSLog(@"%@ -- %@", responseObject, message);

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,2000 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            YJBillRetDTO* d = [YJBillRetDTO new];
            d.billRetStatus=responseObject;
            d.billRetStatusMessage=message;
            completionHandler(d, NO);
        });
 
    }];
    
}

//退款
- (void)_YJBillRefund:(YJBillRefundDTO *)dto complete:(void (^)(YJBillRetDTO *, BOOL))completionHandler {
    NSMutableDictionary *dictM1 = [NSMutableDictionary dictionary];
    [dictM1 setObject:dto.refundOrderNo forKey:@"refundOrderNo"]; //退款订单编号
    [[YJBillPlatform sharedSingleton] billRefundWithOrderInfo:dictM1 payfinishBlock:^(id  _Nonnull responseObject, NSString * _Nonnull message) {
        NSLog(@"%@ %@",responseObject, message);
        YJBillRetDTO* d = [YJBillRetDTO new];
        d.billRetStatus=responseObject;
        d.billRetStatusMessage=message;
        completionHandler(d, YES);
    }];
}

//账单中心
- (void)_YJBillList:(YJBillListDTO *)dto complete:(void (^)(BOOL))completionHandler {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:dto.businessCstNo forKey:@"businessCstNo"]; //会员标识
    //当前app注册的appScheme,请务必填写与plist中注册的一样，否则无法从第三方返回当前app
    [[YJBillPlatform sharedSingleton] billListCurrentViewController:[Unity sharedInstance].getCurrentVC appScheme:dto.appScheme payType:dto.payType OrderInfo:dictM];
}


@end
 
