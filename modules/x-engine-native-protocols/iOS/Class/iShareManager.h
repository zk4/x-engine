//
//  iShareManager.h
//  x-engine-native-protocols
//
//  Created by jabraknight on 2021/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ContentModel,ShareInfoModel;
@protocol iShareManager <NSObject>

/// 分享事件
/// @param type 分享类型
/// @param dto 分享的信息
/// @param completionHandler 分享结果
- (void)shareChannel:(nonnull NSString *)channel type:(NSString *)type shareData:(nonnull ShareInfoModel *)dto complete:(nonnull void (^)(BOOL))completionHandler ;
///temp
- (void)shareTypeWithType:(NSString *)type shareImage:(UIImage *)image complete:(void (^)(BOOL complete)) completionHandler;
@end

NS_ASSUME_NONNULL_END
