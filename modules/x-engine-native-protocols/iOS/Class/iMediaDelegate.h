//
//  iMediaDelegate.h
//  x-engine-native-protocols
//
//  Created by cwz on 2021/8/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol iMediaDelegate <NSObject>
/// 发送上传请求
/// @param url 地址
/// @param header header
/// @param imageData 图片data
/// @param imageName 图片名称
/// @param success 成功结果
/// @param failure 失败结果
- (void)sendUploadRequestWithUrl:(NSString *)url header:(NSDictionary *)header imageData:(NSData *)imageData imageName:(NSString *)imageName success:(void (^)(NSDictionary *dict))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
