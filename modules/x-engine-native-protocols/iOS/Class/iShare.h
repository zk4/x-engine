//
//  iShare.h
//  x-engine-native-protocols
//
//  Created by jabraknight on 2021/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ShareInfoModel;
@protocol iShare <NSObject>

    - (NSArray<NSString*>*_Nullable) getTypes;
    - (NSString*_Nullable) getName;
    - (void)shareChannel:(nonnull NSString *)channel type:(NSString *)type shareData:(nonnull ShareInfoModel *)dto complete:(nonnull void (^)(BOOL))completionHandler ;

@end

NS_ASSUME_NONNULL_END
