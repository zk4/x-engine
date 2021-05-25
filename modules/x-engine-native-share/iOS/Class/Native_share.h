//
//  Native_share.h
//  share
//
//  Copyright © 2020 @zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XENativeModule.h"
#import "iShareManager.h"
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ContentModel : JSONModel

@property (nonatomic, copy)NSString *imgUrl;
@property (nonatomic, assign)NSData *imgData;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *link;
@property (nonatomic, copy)NSString *path;
@property (nonatomic, assign)int minProgramType;
@property (nonatomic, copy)NSString *userName;
@end

@interface ShareInfoModel : JSONModel
@property (nonatomic, copy)NSString *channel;
@property (nonatomic, copy)NSString *shareType;
@property (nonatomic, strong)ContentModel *contentInfo;

@end


@interface Native_share : XENativeModule <iShareManager>

@end

NS_ASSUME_NONNULL_END
