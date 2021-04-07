//
//  istore.h
//  store
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#ifndef istore_h
#define istore_h

@protocol iStore <NSObject>

/// 读取相应的键
/// @param key 键 参看： set
- (id)get:(NSString *)key;

/// 存储键值对
/// @param key 键: 如果有 namespace 的需求，应该在顶层再自行编码。如
/// namespace1:key2  namespace2:key2 作为 key 值。
/// @param val 任意 Object 类型
- (void)set:(NSString *)key val:(id)val;

/// api 存档
/// 默认在 UIApplicationDidEnterBackgroundNotification 时，会进行持久化
- (void)saveTodisk;

/// api 取档
/// 默认在 UIApplicationDidFinishLaunchingNotification 时，
/// 会自动读取档案。
/// @param merge 是否要 merge 已经存在的档案，当前档案将被覆盖
- (void)loadFromDisk:(BOOL)merge;
@end
#endif /* istore_h */
