//
//  iShare.h
//  x-engine-native-protocols
//
//  Created by jabraknight on 2021/5/28.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ChannelStatusDTO;
@class PosterDTO;

@interface ChannelDTO :JSONModel
@property(nonatomic,copy) NSString *channel;
@property(nonatomic,copy) NSString *shareType;
@property(nonatomic,copy) NSString* shareImgData;
@end

@interface OpenShareUiDTO :JSONModel
@property(nonatomic,copy) NSString *shopWechatGroupImgUrl;
@property(nonatomic,copy) NSString* posterImgUrl;
@property(nonatomic,strong) NSArray<ChannelDTO*>* channelList;
@end


@protocol iShare <NSObject>

- (NSArray<NSString*>*_Nullable)getChannels;
- (NSString *_Nullable)getName;
/**
 分享
 */
- (void)shareWithType:(NSString *)type channel:(NSString *)channel posterInfo:(NSDictionary *)info complete:(void (^)(BOOL complete)) completionHandler;
@end


NS_ASSUME_NONNULL_END
