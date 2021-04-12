//
//  iSecurify.h
//  securify
//
//  Created by cwz on 2021/4/8.
//  Copyright © 2021 zk. All rights reserved.
//

#ifndef iSecurify_h
#define iSecurify_h

@protocol iSecurify <NSObject>
/// 判断本地是否有microapp.json文件
/// @param path 路径
- (BOOL)judgeLocationIsHaveMicroAppJsonWithPath:(NSString *)path;

/// 保存microapp.json数据
/// @param jsonDict json数据
- (void)saveMicroAppJsonWithJson:(NSDictionary *)jsonDict;

/// 判断模块是否可用
/// @param moduleName 模块名称
- (BOOL)judgeModuleIsAvailableWithModuleName:(NSString *)moduleName;

/// 判断网络白名单
/// @param hostName host名称
- (BOOL)judgeNetworkIsAvailableWithHostName:(NSString *)hostName;
@end
#endif /* iSecurify_h */
