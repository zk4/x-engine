//
//  BillPlatform.h
//  Bill
//
//  Created by 曾豪 on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJBillPlatform : NSObject


+ (instancetype)sharedSingleton;

#pragma mark -- 订单列表
/*!
 * @abstract 账单中心
 *
 * @param vc   当前控制器
 * @param appScheme  当前app注册的appScheme，  C端必传 B端非必填
 * @param payType  支付业务， 是否是 B端调用，  YES为B， NO为C
 * @param orderInfo     目前只需要传递会员标识
 * 示例：
 *  NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    //会员id
    [dictM setObject:@"000001" forKey:@"businessCstNo"];
    // 房间编号
    [dictM setObject:@"roomNo" forKey:@"roomNo"];
    // 人房编号
    [dictM setObject:@"userRoomNo" forKey:@"userRoomNo"];
 */
-(void)billListCurrentViewController:(UIViewController *)vc
                           appScheme:(NSString *)appScheme
                             payType:(BOOL)payType
                           OrderInfo:(NSMutableDictionary*)orderInfo;

#pragma mark -- 支付
/*!
 * @abstract 无感支付.      注： 此接口需要配合支付查证接口使用
 *
 * @param orderInfo   业务参数，目前需要传递会员标识、业务系统订单号、预下单平台商户号
 * @param appScheme  当前app注册的appScheme   C端必传 B端非必填
 * @param payType  支付业务， 是否是 B端调用，  YES为B， NO为C
 * @param payfinishBlock     回调 (responseObject 1 支付成功   2 支付异常，  message；描述)
 *
 *  示例
 *  NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    ///会员id
    [dictM setObject:@"000001" forKey:@"businessCstNo"];
    ///账单编号
    [dictM setObject:@"18d320a09ebcfb6d0291883ac308ac64" forKey:@"billNo"];
    ///预下单的平台商户号
    [dictM setObject:@"8377631273379692750" forKey:@"platMerCstNo"];
    ///预下单的交易商户号
    [dictM setObject:@"8377707718294634760" forKey:@"tradeMerCstNo"];
 */
-(void)billPaymentWithOrderInfo:(NSMutableDictionary*)orderInfo
                      appScheme:(NSString *)appScheme
                        payType:(BOOL)payType
                 payfinishBlock:(void(^)(id responseObject, NSString *message))payfinishBlock;


#pragma mark  --  退款
/*!
 * @abstract 退款
 *
 * @param orderInfo   业务参数，目前需要传递退款账单编号信息
 * @param payfinishBlock     回调 (responseObject 1 支付成功   2 支付异常，  message；描述)
 *  示例：
    NSMutableDictionary *dictM1 = [NSMutableDictionary dictionary];
    [dictM1 setObject:@"refundOrderNo" forKey:@"refundOrderNo"]; //退款订单编号
 */

-(void)billRefundWithOrderInfo:(NSMutableDictionary *)orderInfo
                payfinishBlock:(void(^)(id responseObject, NSString *message))payfinishBlock;

/*
 *第三方支付查证接口
 *当应用返回前台时触发 在调用无感支付接口时，需要在对应位置调用此方法，来调起主动查证支付结果
*/
-(void)payVerification;

/*
 universalLink地址配置
 */
-(void)setWeChatAppId:(NSString *)weChatAppId
        UniversalLink:(NSString *)universalLink;

/*!
 * @abstract 地址配置
 *
 * @param cashSDKAddress   支付收银台地址
 * @param billSDKAddress    账单中心地址
 */
-(void)setCashSDKAddress:(NSString *)cashSDKAddress
          billSDKAddress:(NSString *)billSDKAddress;


@end

NS_ASSUME_NONNULL_END
