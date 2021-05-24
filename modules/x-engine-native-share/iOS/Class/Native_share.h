//
//  Native_share.h
//  share
//
//  Copyright © 2020 @zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NativeModule.h"
#import "iShareManager.h"
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChannelListModel : JSONModel

@property (nonatomic, copy)NSString *channel;
@property (nonatomic, copy)NSString *shareType;

@end

@interface ShareGoodsModel : JSONModel

@property (nonatomic, copy)NSString *imgUrl;
@property (nonatomic, copy)NSString *imgData;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *link;
@property (nonatomic, copy)NSString *path;
@property (nonatomic, copy)NSString *minProgramType;
@property (nonatomic, strong)NSArray<ChannelListModel*> *channelList;

@end

@interface ShareStatusModel: JSONModel
@property (nonatomic, copy) NSString* resultCode;
@property (nonatomic, copy) NSString* resultMessage;
@end

@interface Native_share : NativeModule <iShareManager>

@end

NS_ASSUME_NONNULL_END
