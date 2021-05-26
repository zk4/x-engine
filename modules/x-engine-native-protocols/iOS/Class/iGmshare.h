//
//  iGmshare.h
//  x-engine-native-protocols
//
//  Created by jabraknight on 2021/5/25.
//

#import "JSONModel.h"
@class ChannelStatusDTO;
NS_ASSUME_NONNULL_BEGIN

@interface ChannelDTO : JSONModel
//分享渠道标签  wx_friend (微信好友) wx_zone（朋友圈）gome（国美） create_poster(生成海报) save_img(保存图片)
@property (nonatomic, copy)NSString *channel;
//分享类型 text (文字) img (图片) link (链接) miniProgram (微信小程序)
@property (nonatomic, copy)NSString *shareType;

@end

@interface OpenShareUiDTO : JSONModel

@property (nonatomic,  copy)NSString *shopWechatGroupImgUrl;
//展示的分享渠道
@property (nonatomic,strong)NSArray<ChannelDTO *> *channelList;

@end

//@interface ChannelStatusDTO : JSONModel
////分享渠道标签  wx_friend (微信好友) wx_zone（朋友圈）gome（国美） create_poster(生成海报) save_img(保存图片)
//@property (nonatomic, copy)NSString *channel;
//  //分享类型 text (文字) img (图片) link (链接) miniProgram (微信小程序)
//@property (nonatomic, copy)NSString *shareType;
//  //分享图片的base64
//@property (nonatomic, copy)NSString *shareImgData;
//
//@end
//海报信息
@interface PosterDTO : JSONModel
//海报类型  goods(商品) shop(店铺) activity(活动)
@property (nonatomic, copy)NSString *posterType;
  //海报图片
@property (nonatomic, copy)NSString *posterImgUrl;
  //店铺logo url地址
@property (nonatomic, copy)NSString *shopLogoUrl;
  //店铺名称
@property (nonatomic, copy)NSString *shopName;
  //店铺地址 （店铺海报必传）
@property (nonatomic, copy)NSString *shopAddress;
  //右下角二维码图片
@property (nonatomic, copy)NSString *rightCornerImg;
  //小程序二维码图片
@property (nonatomic, copy)NSString *minProgramImg;
  //商品的名称（商品海报必传）
@property (nonatomic, copy)NSString *goodsTitle;
  //商品的价格（商品海报必传）
@property (nonatomic, copy)NSString *goodsPrice;
  //活动名称（活动海报必传）
@property (nonatomic, copy)NSString *activityName;

@end

@protocol iGmshare <NSObject>

- (void)createPoster:(PosterDTO *)dto ;

- (void)openShareUi:(OpenShareUiDTO *)dto complete:(void (^)(ChannelStatusDTO *, BOOL))completionHandler ;

@end
NS_ASSUME_NONNULL_END
