//
//  TZWalletSDK.h
//  TZWalletSDK
//
//  Created by ele on 2021/1/13.
//

#import <Foundation/Foundation.h>
@interface TZWalletSDK : NSObject

/*
 收银台初始化方法
 */
+(instancetype _Nonnull )shareInstance;
/*
 钱包地址配置
 */
-(void)setWalletSDKAddress:(NSString *_Nonnull)walletSDKAddress;
/*
 调用钱包
 
 NSMutableDictionary *inf = [NSMutableDictionary dictionary];
 [inf setObject:walletPlatMerCstNoStr forKey:@"platMerCstNo"];
 [inf setObject:walletBusinessCstNameStr forKey:@"businessCstName"];
 [inf setObject:walletBusinessCstNoStr forKey:@"businessCstNo"];
 [inf setObject:walletBusinessCstMobileNoStr forKey:@"businessCstMobileNo"];
 
 TZWalletSDK *cashsdk = [TZWalletSDK shareInstance];
 [cashsdk setWalletSDKAddress:walletServerTFStr];
 [cashsdk callWalletWithInfo:inf withScheme:@"tzcashsdkdemo" finishBlock:^{
     
 }];
 
 info:调用钱包传入的个人会员及商户相关信息
 appScheme:当前app注册的appScheme,请务必填写与plist中注册的一样，否则无法从第三方返回当前app
 finishBlock:回调
 */
-(void)callWalletWithInfo:(NSMutableDictionary *_Nonnull)info withScheme:(NSString *_Nonnull)appScheme finishBlock:(void(^_Nonnull)(void))finishBlock;

@end
