//
//  iShareManager.h
//  x-engine-native-protocols
//
//  Created by jabraknight on 2021/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol iShareManager <NSObject>
/**
 分享
 */
- (void)shareWithType:(NSString *)type channel:(NSString *)channel posterInfo:(NSDictionary *)info complete:(void (^)(BOOL complete)) completionHandler;
@end

NS_ASSUME_NONNULL_END
