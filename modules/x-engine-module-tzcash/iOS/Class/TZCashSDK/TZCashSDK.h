//
//  TZCashSDK.h
//  TZCashSDK
//
//  Created by Shirley on 6/23/20.
//  Copyright © 2020 Shirley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZCashSDK : NSObject
/*
 收银台初始化方法
 */
+(instancetype)shareInstance;
/*
 调用支付收银台
 orderInf:调用收银台传入的订单相关信息
 payfinishBlock:收银台回调
 orderStatus:当前订单的状态 10 初始状态，70 失败，80关闭 90成功
 
 NSMutableDictionary *orderInf = [NSMutableDictionary dictionary];
 [orderInf setObject:orderFlowNo forKey:@"orderNoList"];//预下单返回的订单流水号
 [orderInf setObject:businessCstNo forKey:@"businessCstNo"];//预下单的业务平台客户号
 [orderInf setObject:platMerCstNo forKey:@"platMerCstNo"];//预下单的平台商户号
 TZCashSDK *cashsdk = [TZCashSDK shareInstance];
 [cashsdk callPaymentWithOrderInfo:orderInf payfinishBlock:^(NSString *orderStatus) {
     
     NSLog(@"%@",orderStatus);
 }];
 */
-(void)callPaymentWithOrderInfo:(NSMutableDictionary *)orderInfo payfinishBlock:(void(^)(NSString *orderStatus))payfinishBlock;


@end
