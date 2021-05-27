//
//  XEAFNetworkUtil.h
//  network
//
//  Created by 吕冬剑 on 2020/9/24.
//  Copyright © 2020 edz. All rights reserved.
//
/*
 此文件不应该包含在net模块中, 应该作为组件, 单独存在.
 net中不包含实际的网络组件, 就变为了容器, 花式组件只要实现了协议, 就可以填充到容器中, 增加了扩展性
 */

#import <Foundation/Foundation.h>
#import "XENetworkprotocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface XEAFNetwork4Util : NSObject <XENetworkprotocol>

+(instancetype)instance;

@end

NS_ASSUME_NONNULL_END
