//
//  iShare.h
//  x-engine-native-protocols
//
//  Created by jabraknight on 2021/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ChannelListModel,ShareGoodsModel,ShareStatusModel;
@protocol iShare <NSObject>

    - (NSArray<NSString*>*_Nullable) getTypes;
    - (NSString*_Nullable) getName;
    - (NSString*_Nullable) getIconUrl;
    - (void)shareTypeWithType:(NSString *)type shareData:(ShareGoodsModel *)dto complete:(void (^)(ShareStatusModel* result,BOOL complete)) completionHandler;

@end

NS_ASSUME_NONNULL_END
