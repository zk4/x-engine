//
//  iShareManager.h
//  x-engine-native-protocols
//
//  Created by jabraknight on 2021/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ChannelListModel,ShareGoodsModel,ShareStatusModel;
@protocol iShareManager <NSObject>

/// 分享事件
/// @param type 分享类型
/// @param dto 分享的信息
/// @param completionHandler 分享结果
- (void)shareTypeWithType:(NSString *)type shareData:(ShareGoodsModel *)dto complete:(void (^)(ShareStatusModel* result,BOOL complete)) completionHandler;
@end

NS_ASSUME_NONNULL_END
